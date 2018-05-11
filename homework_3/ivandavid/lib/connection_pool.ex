defmodule ConnectionPool do
  def init(connections) do
    pool = Enum.to_list(1..connections)
    Agent.start_link(fn -> pool end, name: __MODULE__)
    nil
  end

  def get_connection do
    Agent.get_and_update(__MODULE__, fn [x | xs] -> {x, xs ++ [x]} end)
  end
end
