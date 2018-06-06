defmodule ConnectionPool do

  def init(max_connections) do
    Agent.start_link(fn -> Enum.map(1..max_connections, fn(connection) -> connection end) end, name: __MODULE__)
  end

  def get_connection() do
    Agent.get_and_update(__MODULE__, fn(state) -> { hd(state), tl(state) ++ [hd(state)] } end )
  end

end
