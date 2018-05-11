defmodule TicTacToe do
  @behaviour TicTacToeBehavior

  def start_link do
    state = TicTacToeLib.initialize()
    {:ok, spawn_link(fn -> loop(state) end)}
  end

  def play(server_pid, player, {row, column}) when is_pid(server_pid) and is_atom(player) and is_integer(row) and is_integer(column) do
    msg = {:play, player, {row, column}}
    send(server_pid, {:request, self(), msg})
    receive do
      {:reply, reply} -> reply
      # TODO:  Queda pendiente dibujar el tablero actual
      # asi como convertir los atomos a mensajes de texto
    after
      5000 -> {:error, :timeout}
    end
  end

  defp loop(state) do
    receive do
      {:request, from, msg} -> {reply, new_state} = handle_msg(msg, state)
                               reply(from, reply, new_state)
                               loop(new_state)
    end
  end

  defp handle_msg({:play, player, {row, col}}, state) do
    TicTacToeLib.play(player, row, col, state)
  end

  defp reply(pid, reply, state) do
    send(pid, {:reply, {reply, TicTacToeLib.get_board(state)}})
  end
end
