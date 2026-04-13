open Base
open Eio.Std
module Response_io = Cohttp.Response.Private.Make (Cohttp_eio.Private.IO)

type message =
  { stream_name : string
  ; position : int64
  ; time : string
  ; data : Yojson.Safe.t
  ; meta : Yojson.Safe.t
  ; message_type : string
  }

let parse_message (row : Pgx.row) : message option =
  match row with
  | [ stream_name; position; time; data; meta; message_type ] ->
    Some
      { stream_name = Pgx.Value.to_string stream_name |> Option.value_exn
      ; position = Pgx.Value.to_int64 position |> Option.value_exn
      ; time = Pgx.Value.to_string time |> Option.value_exn
      ; data =
          Pgx.Value.to_string data
          |> Option.map ~f:Yojson.Safe.from_string
          |> Option.value ~default:`Null
      ; meta =
          Pgx.Value.to_string meta
          |> Option.map ~f:Yojson.Safe.from_string
          |> Option.value ~default:`Null
      ; message_type = Pgx.Value.to_string message_type |> Option.value_exn
      }
  | _ -> None

let yojson_of_message (m : message) : Yojson.Safe.t =
  `Assoc
    [ ("stream_name", `String m.stream_name)
    ; ("position", `Intlit (m.position |> Int64.to_string))
    ; ("time", `String m.time)
    ; ("data", m.data)
    ; ("meta", m.meta)
    ; ("message_type", `String m.message_type)
    ]

module Db = struct
  let connect () =
    Pgx_lwt_unix.connect
      ~host:"localhost"
      ~port:5432
      ~user:"message_store"
      ~ssl:`No
      ~database:"message_store"
      ()

  let pool = Lwt_pool.create 10 ~dispose:Pgx_lwt_unix.close connect

  let get_category_messages_query =
    {|SELECT stream_name, position, time, data::jsonb, metadata::jsonb, type
      FROM get_category_messages($1, $2, 10)|}

  let get_category_messages stream_name position =
    let rows =
      Lwt_eio.run_lwt_in_main
      @@ fun () ->
      Lwt_pool.use pool (fun conn ->
        Pgx_lwt_unix.execute
          conn
          get_category_messages_query
          ~params:Pgx.Value.[ of_string stream_name; of_int64 position ])
    in
    List.filter_map rows ~f:parse_message
end

let json_headers =
  Cohttp.Header.init_with "content-type" "application/json; charset=utf-8"

let add_connection_header req headers =
  match Cohttp.Header.connection headers with
  | Some _ -> headers
  | None ->
    Cohttp.Header.add
      headers
      "connection"
      (if Cohttp.Request.is_keep_alive req then "keep-alive" else "close")

let respond_string req ?(headers = Cohttp.Header.init ()) ~status ~body () =
  let headers = add_connection_header req headers in
  let response =
    Cohttp.Response.make
      ~status
      ~headers
      ~encoding:(Cohttp.Transfer.Fixed (Int64.of_int (String.length body)))
      ()
  in
  ( response
  , fun _ic oc ->
      Eio.Buf_write.string oc body;
      Eio.Buf_write.flush oc )

let not_found req = respond_string req ~status:`Not_found ~body:"Not found" ()

let method_not_allowed req =
  let headers = Cohttp.Header.init_with "allow" "GET" in
  respond_string req ~headers ~status:`Method_not_allowed ~body:"Method not allowed" ()

let get_category_messages category_name position req =
  let messages = Db.get_category_messages category_name position in
  let body = `List (List.map ~f:yojson_of_message messages) |> Yojson.Safe.to_string in
  respond_string req ~headers:json_headers ~status:`OK ~body ()

let router =
  Routes.(one_of [ route (s "category" / str / int64 /? nil) get_category_messages ])

let callback _conn req _body =
  match Cohttp.Request.meth req with
  | `GET ->
    let target = req |> Cohttp.Request.uri |> Uri.path in
    (match Routes.match' router ~target with
     | FullMatch response | MatchWithTrailingSlash response -> response req
     | NoMatch -> not_found req)
  | _ -> method_not_allowed req

let port () =
  Sys.getenv "PORT" |> Option.bind ~f:Int.of_string_opt |> Option.value ~default:3000

let () =
  Eio_main.run
  @@ fun env ->
  let port = port () in
  Lwt_eio.with_event_loop ~clock:(Eio.Stdenv.clock env)
  @@ fun _ ->
  Switch.run
  @@ fun sw ->
  let socket =
    Eio.Net.listen
      ~sw
      (Eio.Stdenv.net env)
      ~reuse_addr:true
      ~reuse_port:false
      ~backlog:128
      (`Tcp (Eio.Net.Ipaddr.V4.any, port))
  in
  Stdlib.Printf.printf "Listening on http://0.0.0.0:%d\n%!" port;
  let server = Cohttp_eio.Server.make_expert ~callback () in
  let domain_count = Int.min (Domain.recommended_domain_count () - 1) 10 |> Int.max 1 in
  Stdlib.Printf.printf "Starting %d domains\n%!" domain_count;
  Cohttp_eio.Server.run
    socket
    server
    ~additional_domains:(Eio.Stdenv.domain_mgr env, domain_count)
    ~on_error:(fun ex -> Stdlib.prerr_endline (Stdlib.Printexc.to_string ex))
