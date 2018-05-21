defmodule TicTacToe.Display do

  def print_board(game_state) do
    Enum.each(game_state.board, fn columns ->
      print_row(columns)
    end)
  end

  defp print_row(columns),
    do: :io.fwrite("|~3.2s|~3.2s|~3.2s|~n", Enum.map(columns, &(mark_for_player(&1.player))))

  defp mark_for_player(:player_1), do: "x"
  defp mark_for_player(:player_2), do: "o"
  defp mark_for_player(nil), do: " "

end
