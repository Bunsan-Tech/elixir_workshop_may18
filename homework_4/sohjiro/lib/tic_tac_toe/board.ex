defmodule TicTacToe.Board do
  @size 3
  defstruct player: nil
  alias TicTacToe.Board

  def new() do
    1..9
    |> Enum.map(&create(&1))
    |> Enum.chunk_every(@size)
  end

  defp create(_number), do: %Board{}

  def valid?(index, coordinate), do: index?(index, coordinate)
  defp index?(index, coordinate), do: index == calculate_index(coordinate)
  defp calculate_index({row, column}), do: row * @size + column

  def mark_square(board, player, position) do
    board
    |> List.flatten
    |> Stream.with_index
    |> Stream.map(&mark_with_position(&1, player, position))
    |> Enum.chunk_every(@size)
  end

  defp mark_with_position({square, index}, player, coordinate) do
    case Board.valid?(index, coordinate) do
      true ->
        %Board{player: player}
      false -> square
    end
  end

end
