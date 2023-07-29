open Opium

let row_to_yojson (row : Pgx.row) =
  match row with
  | [ stream_name; position; time; data; meta; message_type ] ->
      `Assoc
        [
          ( "stream_name",
            `String (Pgx.Value.to_string stream_name |> Option.get) );
          ( "position",
            `Intlit
              (Pgx.Value.to_int64 position |> Option.get |> Int64.to_string) );
          ("time", `String (Pgx.Value.to_string time |> Option.get));
          ( "data",
            Pgx.Value.to_string data
            |> Option.map Yojson.Safe.from_string
            |> Option.value ~default:`Null );
          ( "meta",
            Pgx.Value.to_string meta
            |> Option.map Yojson.Safe.from_string
            |> Option.value ~default:`Null );
          ( "message_type",
            `String (Pgx.Value.to_string message_type |> Option.get) );
        ]
  | _ -> `Null

module Db = struct
  let connect () =
    Pgx_lwt_unix.connect ~host:"localhost" ~port:5432 ~user:"message_store"
      ~ssl:`No ~database:"message_store" ()

  let pool = Lwt_pool.create 50 ~dispose:Pgx_lwt_unix.close connect

  let get_category_messages_query =
    {|SELECT stream_name, position, time, data::jsonb, metadata::jsonb, type
      FROM get_category_messages($1, $2)|}

  let get_category_messages stream_name position : Yojson.Safe.t list Lwt.t =
    Lwt_pool.use pool (fun conn ->
        Pgx_lwt_unix.execute conn get_category_messages_query
          ~params:Pgx.Value.[ of_string stream_name; of_int64 position ])
    |> Lwt.map (List.map row_to_yojson)
end

let get_category_messages req =
  let open Lwt.Syntax in
  let stream_name = Router.param req "category_name"
  and position = Router.param req "position" |> Int64.of_string in

  let+ messages = Db.get_category_messages stream_name position in
  let json = `List messages in
  Response.of_json json

let set_logger () =
  Logs.set_level (Some Logs.Info);
  Logs.set_reporter (Logs_fmt.reporter ())

let () =
  set_logger ();

  App.empty
  |> App.get "/category/:category_name/:position" get_category_messages
  |> App.run_command
