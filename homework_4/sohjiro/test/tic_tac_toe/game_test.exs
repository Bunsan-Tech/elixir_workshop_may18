defmodule TicTacToe.GameTest do
  use ExUnit.Case
  alias TicTacToe.Game

  test "should validate users turn" do
    name = "name"
    {:ok, pid} = Game.start_link(name)

    {:error, message} = Game.play(name, :player_2, {0, 0})
    assert message == "It's not your turn!"

    {:ok, game_message} = Game.play(name, :player_1, {0, 0})
    game_state = :sys.get_state(pid)

    assert %{
      board: [
        [%TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}]
      ],
      turn: :player_2,
      winner: nil
    } == game_state
    assert game_message == "Game is on!"
  end

  test "a player can't mark an already marked square" do
    name = "name"
    {:ok, _pid} = Game.start_link(name)

    {:ok, _board} = Game.play(name, :player_1, {0, 0})
    {:error, message} = Game.play(name, :player_2, {0, 0})

    assert message == "Square is not available"
  end

  test "There should be a winner after a complete line" do
    name = "name"
    {:ok, game} = Game.start_link(name)

    :sys.replace_state(game, fn state_data ->
      %{ state_data | board: [
        [%TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}]
      ]}
    end)

    {:ok, game_message} = Game.play(name, :player_1, {0, 2})
    game_state = :sys.get_state(game)

    assert game_state.winner == :player_1
    assert game_state.turn
    assert game_state.board
    assert game_message == "Game over"
  end

  test "There shouldn't be more moves after a winner" do
    name = "name"
    {:ok, game} = Game.start_link(name)

    :sys.replace_state(game, fn state_data ->
      %{ state_data | board: [
        [%TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}]
      ]}
    end)

    {:ok, game_message} = Game.play(name, :player_1, {0, 2})
    game_state = :sys.get_state(game)
    assert game_state.winner == :player_1
    assert game_message == "Game over"

    {:ok, final_message} = Game.play(name, :player_1, {0, 2})
    assert final_message == "Game over"
    refute Process.alive?(game)
  end

end
