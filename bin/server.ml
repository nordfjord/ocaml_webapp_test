open Opium

module Message = struct
  type t = {
    stream_name : string;
    position : int64;
    data : Yojson.Safe.t;
    meta : Yojson.Safe.t;
    time: Ptime.t;
    message_type : string;
  }

  let to_yojson m : Yojson.Safe.t =
    `Assoc
      [
        ("stream_name", `String m.stream_name);
        ("message_type", `String m.message_type);
        ("position", `Intlit (Int64.to_string m.position));
        ("time", `String (Ptime.to_rfc3339 m.time));
        ("data", m.data);
        ("meta", m.meta);
      ]

  let cacti =
    Caqti_type.custom
      ~encode:(fun _ -> Error "Encoding not supported")
      ~decode:(fun ((stream_name, position, time), (data', meta, message_type)) ->
        try
          let data =
            match data' with
            | "" -> `Null
            | data -> (
                match Yojson.Safe.from_string data with
                | `String str -> Yojson.Safe.from_string str
                | value -> value)
          and meta =
            match meta with
            | "" -> `Null
            | meta -> (
                match Yojson.Safe.from_string meta with
                | `String str -> Yojson.Safe.from_string str
                | value -> value)
          in

          Ok { stream_name; position; time; data; meta; message_type }
        with e -> Error (Printexc.to_string e))
      Caqti_type.(tup2 (tup3 string int64 ptime) (tup3 string string string))
end

module Db = struct
  open Caqti_request.Infix

  let connect () =
    let maybe_pool =
      "postgresql://message_store:@localhost:5432/message_store"
      |> Uri.of_string
      |> Caqti_lwt.connect_pool ~max_size:10
    in
    match maybe_pool with
    | Ok pool -> pool
    | Error err -> failwith (Caqti_error.show err)

  let pool = connect ()

  let get_category_messages_query =
    Caqti_type.(tup2 string int64 ->* Message.cacti)
      {|SELECT stream_name, position, time, data, metadata AS meta, type AS message_type 
      FROM get_category_messages($1, $2)|}

  let get_category_messages stream_name position
      (module C : Caqti_lwt.CONNECTION) =
    C.collect_list get_category_messages_query (stream_name, position)
end

let get_category_messages req =
  let open Lwt.Syntax in
  let stream_name = Router.param req "category_name"
  and position = Router.param req "position" |> Int64.of_string in
  let+ result =
    Caqti_lwt.Pool.use (Db.get_category_messages stream_name position) Db.pool
  in

  match result with
  | Ok messages ->
      let json = `List (List.map Message.to_yojson messages) in
      Response.of_json json
  | Error err ->
      Response.of_plain_text (Caqti_error.show err)
      |> Response.set_status `Internal_server_error

let app =
  App.empty
  |> App.get "/category/:category_name/:position" get_category_messages
