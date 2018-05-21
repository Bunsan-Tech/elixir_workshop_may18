defmodule TicTacToe.Rules do

  def verify_winner(winner) do
    case is_nil(winner) do
      true -> :ok
      false -> :game_over
    end
  end

  def verify_turn_for_player(turn, player) do
    case turn == player do
      true -> :ok
      false -> :error
    end
  end

  def verify_square_available(board, {row, col}) do
    board
    |> Enum.at(row)
    |> Enum.at(col)
    |> Map.get(:player)
    |> case do
      nil -> :available
      _ -> :not_available
    end

  end
end
