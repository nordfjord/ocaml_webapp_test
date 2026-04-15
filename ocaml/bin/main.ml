open Base
open Eio.Std

type message =
  { stream_name : string
  ; position : int64
  ; time : string
  ; data : Yojson.Safe.t
  ; message_type : string
  }

let parse_json_field row col =
  Pg.get_opt row col
  |> Option.map ~f:Yojson.Safe.from_string
  |> Option.value ~default:`Null

let parse_message row : message =
  { stream_name = Pg.get row 0
  ; position = Pg.get row 1 |> Int64.of_string
  ; time = Pg.get row 2
  ; data = parse_json_field row 3
  ; message_type = Pg.get row 4
  }

let yojson_of_message (m : message) : Yojson.Safe.t =
  `Assoc
    [ ("stream_name", `String m.stream_name)
    ; ("position", `Intlit (m.position |> Int64.to_string))
    ; ("time", `String m.time)
    ; ("data", m.data)
    ; ("message_type", `String m.message_type)
    ]

module Db = struct
  let conninfo = "host=localhost port=5432 user=message_store dbname=message_store"
  let pool = lazy (Pg.make_pool conninfo)
  let init () = ignore (Lazy.force pool)
  let close () = Pg.close_pool (Lazy.force pool)

  let get_category_messages_query =
    {|SELECT stream_name, position, time, data::jsonb,  type
      FROM get_category_messages($1, $2, 10)|}

  let get_category_messages stream_name position =
    Pg.query
      (Lazy.force pool)
      get_category_messages_query
      ~params:[ Pg.String stream_name; Pg.Int64 position ]
    |> List.map ~f:parse_message
end

let json_headers =
  Cohttp.Header.init_with "content-type" "application/json; charset=utf-8"

let respond_string ?(headers = Cohttp.Header.init ()) ~status ~body () =
  Cohttp_eio.Server.respond ~headers ~status ~body:(Cohttp_eio.Body.of_string body) ()

let not_found = respond_string ~status:`Not_found ~body:"Not found"

let method_not_allowed () =
  let headers = Cohttp.Header.init_with "allow" "GET" in
  respond_string ~headers ~status:`Method_not_allowed ~body:"Method not allowed" ()

let get_category_messages category_name position =
  let messages = Db.get_category_messages category_name position in
  let body = `List (List.map ~f:yojson_of_message messages) |> Yojson.Safe.to_string in
  respond_string ~headers:json_headers ~status:`OK ~body ()

let router =
  Routes.(one_of [ route (s "category" / str / int64 /? nil) get_category_messages ])

let callback _conn req _body =
  match Cohttp.Request.meth req with
  | `GET ->
    let target = req |> Cohttp.Request.uri |> Uri.path in
    (match Routes.match' router ~target with
     | FullMatch response | MatchWithTrailingSlash response -> response
     | NoMatch -> not_found ())
  | _ -> method_not_allowed ()

let port () =
  Sys.getenv "PORT" |> Option.bind ~f:Int.of_string_opt |> Option.value ~default:3000

let ( >> ) f g x = g (f x)

let () =
  Eio_main.run
  @@ fun env ->
  let port = port () in
  Switch.run
  @@ fun sw ->
  Db.init ();
  Switch.on_release sw Db.close;
  let log_mutex = Eio.Mutex.create () in
  Logs.set_reporter (Logs_fmt.reporter ());
  Logs.set_reporter_mutex
    ~lock:(fun () -> Eio.Mutex.lock log_mutex)
    ~unlock:(fun () -> Eio.Mutex.unlock log_mutex);
  Logs.set_level ~all:true (Some Logs.Info);
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
  let server = Cohttp_eio.Server.make ~callback () in
  let domain_count = Int.min (Domain.recommended_domain_count () - 1) 10 |> Int.max 1 in
  Stdlib.Printf.printf "Starting %d domains\n%!" domain_count;
  Logs.info (fun m -> m "Starting %d domains" domain_count);
  Cohttp_eio.Server.run
    socket
    server
    ~additional_domains:(Eio.Stdenv.domain_mgr env, domain_count)
    ~on_error:(Stdlib.Printexc.to_string >> Stdlib.prerr_endline)
