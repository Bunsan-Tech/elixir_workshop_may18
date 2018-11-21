defmodule TicTacToeTest do
  use ExUnit.Case

  _expected_print = """
  | | | |
  | |x| |
  | | | |
  """

  test "first play" do
    {:ok, server_pid} = TicTacToe.start_link()
    assert {:ok, "game is on!"} == TicTacToe.play(server_pid, :player_1, {1, 1})
    assert {:ok, "it is not your turn"} == TicTacToe.play(server_pid, :player_1, {0, 0})
    assert {:ok, "game is on!"} == TicTacToe.play(server_pid, :player_2, {0, 1})
    assert {:ok, "game is on!"} == TicTacToe.play(server_pid, :player_1, {0, 0})
    assert {:ok, "game is on!"} == TicTacToe.play(server_pid, :player_2, {1, 2})
    assert {:ok, "player_1 wins!"} == TicTacToe.play(server_pid, :player_1, {2, 2})
  end
end
