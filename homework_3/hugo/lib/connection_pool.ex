defmodule ConnectionPool do

  def init(total_connection) do
    Agent.start_link(fn -> Enum.map(1..total_connection,fn(x) -> x end) end, name: __MODULE__)
  end

  def get_connection do
    Agent.get_and_update(__MODULE__, fn total_connection -> {hd(total_connection), tl(total_connection) ++ [hd(total_connection)] } end)
  end

end
