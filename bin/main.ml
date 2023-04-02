let set_logger () =
  Logs.set_level (Some Logs.Info);
  Logs.set_reporter (Logs_fmt.reporter ())

let () =
  set_logger ();
  Opium.App.run_command Server.app
