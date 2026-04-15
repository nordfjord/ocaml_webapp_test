let error_handler (_client_addr : Eio.Net.Sockaddr.stream) ?request:_ error start_response
  =
  let body =
    match error with
    | `Bad_request -> "Bad request"
    | `Bad_gateway -> "Bad gateway"
    | `Internal_server_error -> "Internal server error"
    | `Exn exn -> Stdlib.Printexc.to_string exn
  in
  let headers =
    Httpun.Headers.of_list
      [ ("content-type", "text/plain; charset=utf-8")
      ; ("content-length", Int.to_string (String.length body))
      ]
  in
  let writer = start_response headers in
  Httpun.Body.Writer.write_string writer body;
  Httpun.Body.Writer.close writer

let json_headers =
  Httpun.Headers.of_list [ ("content-type", "application/json; charset=utf-8") ]

let respond_string ?(headers = Httpun.Headers.empty) reqd ~status ~body =
  let headers =
    Httpun.Headers.add_unless_exists
      headers
      "content-length"
      (Int.to_string (String.length body))
  in
  let response = Httpun.Response.create ~headers status in
  Httpun.Reqd.respond_with_string reqd response body

let not_found reqd = respond_string reqd ~status:`Not_found ~body:"Not found"

let method_not_allowed reqd =
  let headers = Httpun.Headers.of_list [ ("allow", "GET") ] in
  respond_string reqd ~headers ~status:`Method_not_allowed ~body:"Method not allowed"

let ( >> ) f g x = g (f x)

let run ~sw ~net ~port ~domain_mgr request_handler =
  let socket =
    Eio.Net.listen
      ~sw
      net
      ~reuse_addr:true
      ~reuse_port:false
      ~backlog:128
      (`Tcp (Eio.Net.Ipaddr.V4.any, port))
  in
  Logs.app (fun m -> m "Listening on http://0.0.0.0:%d" port);
  let domain_count = Int.min (Domain.recommended_domain_count () - 1) 10 |> Int.max 1 in
  Logs.app (fun m -> m "Starting %d domains" domain_count);
  let handler =
    Httpun_eio.Server.create_connection_handler ~request_handler ~error_handler ~sw
  in
  Eio.Net.run_server
    socket
    ~additional_domains:(domain_mgr, domain_count)
    ~on_error:(Stdlib.Printexc.to_string >> Stdlib.prerr_endline)
    (fun flow client_addr -> handler client_addr flow)
