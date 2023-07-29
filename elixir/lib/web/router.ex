defmodule Web.Router do
  @moduledoc """
  A Plug responsible for logging request info, parsing request body's as JSON,
  matching routes, and dispatching responses.
  """

  use Plug.Router

  # This module is a Plug, that also implements it's own plug pipeline, below:

  # Using Plug.Logger for logging request information
  plug(Plug.Logger)
  # responsible for matching routes
  plug(:match)
  # Using Poison for JSON decoding
  # Note, order of plugs is important, by placing this _after_ the 'match' plug,
  # we will only parse the request AFTER there is a route match.
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  # responsible for dispatching responses
  plug(:dispatch)

  # A simple route to test that the server is up
  # Note, all routes must return a connection as per the Plug spec.
  get "/category/:category/:position" do
    %{"category" => category, "position" => position} = conn.params
    position = String.to_integer(position)
    query = """
    select stream_name, position, time, data, metadata, type
    from get_category_messages($1, $2, 10)
    """

    {:ok, result} = Ecto.Adapters.SQL.query(Web.Repo, query, [category, position])

    messages = Enum.map(result.rows, fn [stream_name, position, time, data, metadata, type] ->
      %{
        stream_name: stream_name,
        position: position,
        time: DateTime.from_naive!(time, "Etc/UTC"),
        data: Jason.decode!(data || "null"),
        metadata: Jason.decode!(metadata || "null"),
        type: type
      }
    end)

    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(messages))
  end

  # A catchall route, 'match' will match no matter the request method,
  # so a response is always returned, even if there is no route to match.
  match _ do
    send_resp(conn, 404, "oops... Nothing here :(")
  end
end

