Mix.install([:tesla])

defmodule HexClient do
  use Tesla


  plug(Tesla.Middleware.BaseUrl, "https://adventofcode.com")

  plug(Tesla.Middleware.Headers, [
    {"user-agent", "tesla"},
    {"cookie",
     "session=53616c7465645f5fa031e86ff197ee2b0e53dff66d5658a0189140d543aab050870ca0de8ee612342bf2edca610d4acdb46876be5cc05b29e17ed756599211e4"}
  ])
end

HexClient.get("/2023/day/3/input")
|> IO.inspect()
