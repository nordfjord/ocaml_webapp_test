open Base

type pooled_connection =
  { conn : Postgresql.connection_class
  ; closed : bool Atomic.t
  }

type pool =
  { resources : pooled_connection Eio.Pool.t
  ; tracked_connections : pooled_connection Queue.t
  ; tracked_connections_mutex : Stdlib.Mutex.t
  }

type row =
  { result : Postgresql.result
  ; index : int
  }

type param =
  | Null
  | String of string
  | Int of int
  | Int64 of int64
  | Bool of bool
  | Float of float

let default_pool_size = 10

let close_connection { conn; closed } =
  if Atomic.compare_and_set closed false true then conn#finish

let validate_connection { conn; closed } =
  (not (Atomic.get closed))
  &&
  match conn#status with
  | Postgresql.Ok -> true
  | _ -> false

let unix_fd_of_socket socket =
  Stdlib.Obj.magic socket

let await_flush conn =
  let fd = unix_fd_of_socket conn#socket in
  let rec loop () =
    match conn#flush with
    | Postgresql.Successful -> ()
    | Data_left_to_send ->
      Eio_unix.await_writable fd;
      loop ()
  in
  loop ()

let collect_results conn =
  let fd = unix_fd_of_socket conn#socket in
  let rec wait_until_ready () =
    conn#consume_input;
    if conn#is_busy
    then (
      Eio_unix.await_readable fd;
      wait_until_ready ())
  in
  let rec read_results acc =
    match conn#get_result with
    | Some result -> read_results (result :: acc)
    | None -> List.rev acc
  in
  wait_until_ready ();
  read_results []

let encode_param = function
  | Null -> Postgresql.null
  | String x -> x
  | Int x -> Int.to_string x
  | Int64 x -> Int64.to_string x
  | Bool x -> Bool.to_string x
  | Float x -> Float.to_string x

let get_opt row field =
  if row.result#getisnull row.index field
  then None
  else Some (row.result#getvalue row.index field)

let get row field =
  get_opt row field |> Option.value_exn

let query pool query_str ~params =
  let params = Array.of_list_map params ~f:encode_param in
  Eio.Pool.use pool.resources (fun { conn; _ } ->
    conn#send_query ~params query_str;
    await_flush conn;
    match collect_results conn with
    | [ result ] ->
      (match result#status with
       | Postgresql.Tuples_ok ->
         List.init result#ntuples ~f:(fun index -> { result; index })
       | status ->
         raise
           (Postgresql.Error
              (Unexpected_status (status, result#error, [ Postgresql.Tuples_ok ]))))
    | [] ->
      raise
        (Postgresql.Error
           (Unexpected_status (Empty_query, "Query returned no result", [ Postgresql.Tuples_ok ])))
    | result :: _ ->
      raise
        (Postgresql.Error
           (Unexpected_status
              (result#status, "Query returned multiple results", [ Postgresql.Tuples_ok ]))))

let make_pool ?(pool_size = default_pool_size) conninfo =
  let tracked_connections = Queue.create () in
  let tracked_connections_mutex = Stdlib.Mutex.create () in
  let track_connection pooled_connection =
    Stdlib.Mutex.lock tracked_connections_mutex;
    Queue.enqueue tracked_connections pooled_connection;
    Stdlib.Mutex.unlock tracked_connections_mutex
  in
  let create_connection () =
    let conn = new Postgresql.connection ~conninfo () in
    conn#set_nonblocking true;
    let pooled_connection = { conn; closed = Atomic.make false } in
    track_connection pooled_connection;
    pooled_connection
  in
  { resources =
      Eio.Pool.create
        ~validate:validate_connection
        ~dispose:close_connection
        pool_size
        create_connection
  ; tracked_connections
  ; tracked_connections_mutex
  }

let close_pool pool =
  Stdlib.Mutex.lock pool.tracked_connections_mutex;
  while not (Queue.is_empty pool.tracked_connections) do
    close_connection (Queue.dequeue_exn pool.tracked_connections)
  done;
  Stdlib.Mutex.unlock pool.tracked_connections_mutex
