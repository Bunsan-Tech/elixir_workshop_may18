defmodule TicTacToe do
  def start_link do
    pid = spawn(TicTacToe, :loop, [default_state()])
    {:ok, pid}
  end

  def play(pid, player, {x, y}) do
    send(pid, {player, {x, y}, self()})

    receive do
      msg ->
        msg
    end
  end

  def loop(state) do
    receive do
      {player, {x, y}, sender} ->
        if state[:next_player] == player do
          symbol = get_symbol(player)
          board = put_in(state[:board][x][y], symbol)[:board]
          winner = check_winner(board)
          IO.inspect(board)
          IO.inspect(winner)
          if winner == :none do
            send(sender, {:ok, "game is on!"})
          else
            send(sender, {:ok, "#{winner} wins!"})
          end

          loop(%{state | next_player: get_next_player(player), board: board, winner: winner})
        else
          send(sender, {:ok, "it is not your turn"})
          loop(state)
        end
    end
  end

  defp default_state() do
    %{
      board: %{
        0 => %{0 => "", 1 => "", 2 => ""},
        1 => %{0 => "", 1 => "", 2 => ""},
        2 => %{0 => "", 1 => "", 2 => ""}
      },
      next_player: :player_1,
      winner: :none
    }
  end

  defp get_next_player(player) do
    case player do
      :player_1 ->
        :player_2

      :player_2 ->
        :player_1
    end
  end

  defp get_symbol(player) do
    case player do
      :player_1 ->
        "x"

      :player_2 ->
        "o"
    end
  end

  defp get_player(symbol) do
    case symbol do
      "x" ->
        :player_1

      "o" ->
        :player_2
    end
  end

  defp check_winner(board) do
    if board[0][0] == board[1][1] && board[1][1] == board[2][2] do
      get_player(board[0][0])
    else
      :none
    end
  end
end
