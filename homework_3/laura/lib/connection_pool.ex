defmodule ConnectionPool do
  def init(max) do
    spawn(ConnectionPool, :loop, [default_state(max)])    
  end

  def get_connection(pid) do
    send(pid, {:current, self()})

    receive do
      msg ->
        msg
    end
  end

  def loop(state) do
    receive do
      {:current, sender} ->
        send(sender, state[:current])
        next =
        if (state[:current] + 1) > state[:max] do
          state[:min]
        else
          state[:current] + 1
        end
        loop(%{state | current: next}) 
    end
  end  

  defp default_state(max) do
    %{max: max, min: 1, current: 1}
  end
end