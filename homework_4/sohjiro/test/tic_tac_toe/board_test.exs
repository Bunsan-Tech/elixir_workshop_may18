defmodule TicTacToe.BoardTest do
  use ExUnit.Case
  alias TicTacToe.Board

  test "should create a new board for the game" do
    board = Board.new()

    assert board
    assert [
      [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
      [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
      [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}]
    ] == board
  end

end
