open System
open Microsoft.AspNetCore.Builder
open Microsoft.Extensions.Hosting
open Dapper

[<CLIMutable>]
type Message =
  { stream_name: string
    position: int64
    data: ReadOnlyMemory<byte>
    meta: ReadOnlyMemory<byte>
    time: DateTimeOffset
    message_type: string }

module Db =
  let connect () =
    task {
      let conn =
        new Npgsql.NpgsqlConnection("Host=localhost; Port=5432; Database=message_store; Username=message_store; Maximum Pool Size=80")

      do! conn.OpenAsync()
      return conn
    }

  let get_category_messages (categoryName: string) (position: int64) =
    task {
      use! conn = connect ()

      return!
        conn.QueryAsync<Message>(
          "SELECT stream_name, position, time, data, metadata AS meta, type AS message_type 
           FROM get_category_messages(@CategoryName, @Position)",
          {| CategoryName = categoryName
             Position = position |}
        )
    }

let builder = WebApplication.CreateBuilder()
let app = builder.Build()

app.MapGet(
  "/category/{category_name}/{position}",
  Func<_, _, _>(fun categoryName position ->
    task {
      let! rows = Db.get_category_messages categoryName position
      return rows
    })
)
|> ignore

app.Run()
