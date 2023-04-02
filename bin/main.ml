open Opium

module Person = struct
  type t =
    { name : string
    ; age : int
    }

  let to_yojson t = `Assoc [ ("name", `String t.name); ("age", `Int t.age) ]

  let of_yojson yojson =
    match yojson with
    | `Assoc [ ("name", `String name); ("age", `Int age) ] -> { name; age }
    | _ -> failwith "invalid person json"
end

let print_person_handler req =
  let name = Router.param req "name" in
  let age = Router.param req "age" |> int_of_string in
  let person = Person.to_yojson { Person.name; age } in
  Lwt.return (Response.of_json person)

module Colors = struct
  let orange_ = "\027[38;5;208m"
  let clear = "\027[0m"
  let orange s = orange_ ^ s ^ clear
end

let update_person_handler req =
  let open Lwt.Syntax in
  let+ json = Request.to_json_exn req in
  let person = Person.of_yojson json in
  Logs.info (fun m -> m "Received person: %s" (Colors.orange person.name));
  Response.of_json (`Assoc [ ("message", `String "Person saved") ])

let streaming_handler req =
  let length = Body.length req.Request.body in
  let content = Body.to_stream req.Request.body in
  let body = Lwt_stream.map String.uppercase_ascii content in
  Response.make ~body:(Body.of_stream ?length body) () |> Lwt.return

let print_param_handler req =
  Printf.sprintf "Hello, %s\n" (Router.param req "name")
  |> Response.of_plain_text
  |> Lwt.return

let log_level = Some Logs.Info

(** Configure the logger *)
let set_logger () =
  Fmt_tty.setup_std_outputs ();
  Logs.set_reporter (Logs_fmt.reporter ());
  Logs.set_level log_level

let app =
  App.empty
  |> App.post "/hello/stream" streaming_handler
  |> App.get "/hello/:name" print_param_handler
  |> App.get "/person/:name/:age" print_person_handler
  |> App.patch "/person" update_person_handler

let () =
  set_logger ();
  App.run_multicore app
