open System
open Microsoft.AspNetCore.Builder
open Microsoft.Extensions.Hosting
open Microsoft.Extensions.Logging
open System.Text.Json

type Message<'Format> =
  { stream_name: string
    position: int64
    data: 'Format
    meta: 'Format
    time: DateTimeOffset
    message_type: string }

module Db =
  open Npgsql
  open NpgsqlTypes

  let connect () = task {
    let conn =
      new Npgsql.NpgsqlConnection("Host=localhost; Port=5432; Database=message_store; Username=message_store; Maximum Pool Size=10")

    do! conn.OpenAsync()
    return conn }

  let get_category_messages (categoryName: string) (position: int64) = task {
    use! conn = connect ()
    use cmd = conn.CreateCommand()

    cmd.CommandText <-
      "SELECT stream_name, position, time, data, metadata AS meta, type AS message_type 
         FROM get_category_messages($1, $2, 10)"

    cmd.Parameters.AddWithValue(NpgsqlDbType.Text, box categoryName) |> ignore
    cmd.Parameters.AddWithValue(NpgsqlDbType.Bigint, box position) |> ignore

    use! reader = cmd.ExecuteReaderAsync()

    let result = ResizeArray()

    while reader.Read() do
      result.Add(
        { stream_name = reader.GetString(0)
          position = reader.GetInt64(1)
          time = DateTimeOffset(reader.GetDateTime(2))
          data =
            (if reader.IsDBNull(3) then
               JsonSerializer.Deserialize<JsonElement>("null")
             else
               JsonSerializer.Deserialize(reader.GetString(3)))
          meta =
            (if reader.IsDBNull(4) then
               JsonSerializer.Deserialize<JsonElement>("null")
             else
               JsonSerializer.Deserialize(reader.GetString(4)))
          message_type = reader.GetString(5) }
      )

    return result }

let builder = WebApplication.CreateBuilder()
builder.Logging.AddFilter("Microsoft.AspNetCore", LogLevel.Warning) |> ignore
let app = builder.Build()

app.MapGet(
  "/category/{category_name}/{position}",
  Func<_, _, _>(fun category_name position -> task {
    let! rows = Db.get_category_messages category_name position
    return rows }))
|> ignore

app.Run()
