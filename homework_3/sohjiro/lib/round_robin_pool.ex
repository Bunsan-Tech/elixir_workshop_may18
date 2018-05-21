defmodule ConnectionPool do

  def init(number) do
    pool = 1..number
           |> Enum.map(fn(index) ->
             {:ok, agent_pid} = Agent.start(fn -> %{} end)
               {index, agent_pid}
           end)
    pid = spawn(fn -> loop(pool) end)

    Process.register(pid, __MODULE__)
  end

  defp loop(state) do
    receive do
      {caller, :get} ->
        [{id, agent_pid} = h | rest] = state
        send(caller, {:conn, id, agent_pid})
        loop(rest ++ [h])
    end
  end

  def get_connection() do
    send(__MODULE__, {self(), :get})

    receive do
      {:conn, id, _agent_pid} -> id
      after 5000 -> IO.puts "something were grong"
    end
  end

end
