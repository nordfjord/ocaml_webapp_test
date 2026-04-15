open Base
open Eio.Std
module Headers = Httpun.Headers
module Method = Httpun.Method
module Request = Httpun.Request
module Response = Httpun.Response
module Reqd = Httpun.Reqd
module Status = Httpun.Status

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
  let make_pool () = Pg.make_pool conninfo
  let close pool () = Pg.close_pool pool

  let get_category_messages_query =
    {|SELECT stream_name, position, time, data::jsonb,  type
      FROM get_category_messages($1, $2, 10)|}

  let get_category_messages pool stream_name position =
    Logs.debug (fun m -> m "get_category_messages %s %Ld" stream_name position);
    Pg.query
      pool
      get_category_messages_query
      ~params:[ Pg.String stream_name; Pg.Int64 position ]
    |> List.map ~f:parse_message
end

let get_category_messages pool category_name position reqd =
  let messages = Db.get_category_messages pool category_name position in
  let body = `List (List.map ~f:yojson_of_message messages) |> Yojson.Safe.to_string in
  Server.respond_string reqd ~headers:Server.json_headers ~status:`OK ~body

let make_router pool =
  Routes.(one_of [ (s "category" / str / int64 /? nil) @--> get_category_messages pool ])

let route router target reqd =
  match Routes.match' router ~target with
  | FullMatch response | MatchWithTrailingSlash response -> response reqd
  | NoMatch -> Server.not_found reqd

let request_handler router _ r =
  let reqd = r.Gluten.reqd in
  let req = Reqd.request reqd in
  match req.meth with
  | `GET -> route router req.target reqd
  | _ -> Server.method_not_allowed reqd

let port () =
  Sys.getenv "PORT" |> Option.bind ~f:Int.of_string_opt |> Option.value ~default:3000

let () =
  Eio_main.run
  @@ fun env ->
  let port = port () in
  Switch.run
  @@ fun sw ->
  let pool = Db.make_pool () in
  Switch.on_release sw (Db.close pool);
  let () =
    let m = Stdlib.Mutex.create () in
    let lock () = Stdlib.Mutex.lock m
    and unlock () = Stdlib.Mutex.unlock m in
    Logs.set_reporter_mutex ~lock ~unlock
  in
  Logs.set_reporter (Logs.format_reporter ());
  Logs.set_level (Some Logs.Info);
  let router = make_router pool in
  Server.run
    ~sw
    ~net:(Eio.Stdenv.net env)
    ~port
    ~domain_mgr:(Eio.Stdenv.domain_mgr env)
    (request_handler router)
