open System
open Microsoft.AspNetCore.Builder
open Microsoft.Extensions.Hosting
open Microsoft.Extensions.Logging
open System.Text.Json
open System.Threading.Tasks

[<Struct>]
type Message =
  { stream_name: string
    position: int64
    data: JsonElement
    meta: JsonElement
    time: DateTimeOffset
    message_type: string }

module Json =
  let jsonNull = JsonSerializer.Deserialize<JsonElement>("null")
  let read struct (reader: System.Data.Common.DbDataReader, index: int) : ValueTask<JsonElement> =
    if reader.IsDBNull(index) then
      ValueTask.FromResult(jsonNull)
    else
      JsonSerializer.DeserializeAsync(reader.GetStream(index))

module GetCategoryMessages =
  [<Literal>]
  let Query = "SELECT stream_name, position, time, data::bytea, metadata::bytea, type FROM get_category_messages($1, $2, 10)"

  let prepare struct (conn: Npgsql.NpgsqlConnection, categoryName: string, position: int64) = task {
    let cmd = conn.CreateCommand()
    cmd.CommandText <- Query
    cmd.Parameters.AddWithValue(NpgsqlTypes.NpgsqlDbType.Text, categoryName) |> ignore
    cmd.Parameters.AddWithValue(NpgsqlTypes.NpgsqlDbType.Bigint, position) |> ignore
    do! cmd.PrepareAsync()
    return cmd }

  let read (reader: System.Data.Common.DbDataReader) = task {
    let data = Json.read (reader, 3)
    let meta = Json.read (reader, 4)
    let! data = data
    let! meta = meta
    return {
      stream_name = reader.GetString(0)
      position = reader.GetInt64(1)
      time = DateTimeOffset(reader.GetDateTime(2))
      data = data
      meta = meta
      message_type = reader.GetString(5) } }


module Db =
  open Npgsql
  open NpgsqlTypes

  let dataSource =
    NpgsqlDataSource.Create("Host=localhost; Port=5432; Database=message_store; Username=message_store; Maximum Pool Size=80; Enlist=false")

  let get_category_messages (categoryName: string) (position: int64) = task {
    use! conn = dataSource.OpenConnectionAsync()
    use! cmd = GetCategoryMessages.prepare (conn, categoryName, position)

    use! reader = cmd.ExecuteReaderAsync()

    let result = ResizeArray(10)

    while reader.Read() do
      let! message = GetCategoryMessages.read reader
      result.Add(message)

    return result }

let builder = WebApplication.CreateBuilder()
builder.Logging.SetMinimumLevel(LogLevel.Warning) |> ignore
let app = builder.Build()

app.MapGet(
  "/category/{category_name}/{position}",
  Func<_, _, _>(fun category_name position -> task {
    let! rows = Db.get_category_messages category_name position
    return rows }))
|> ignore

app.Run()
