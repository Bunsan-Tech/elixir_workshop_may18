defmodule TicTacToe.GameTest do
  use ExUnit.Case
  alias TicTacToe.Game

  test "should validate users turn" do
    name = "name"
    {:ok, _pid} = Game.start_link(name)

    {:error, message} = Game.play(name, :player_2, {0, 0})
    assert message == "It's not your turn!"

    {:ok, game_state} = Game.play(name, :player_1, {0, 0})
    assert %{
      board: [
        [%TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
        [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}]
      ],
      turn: :player_2,
      winner: nil
    } == game_state
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

    {:ok, game_state} = Game.play(name, :player_1, {0, 2})

    assert game_state.winner == :player_1
    assert game_state.turn
    assert game_state.board
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

    {:ok, game_state} = Game.play(name, :player_1, {0, 2})
    assert game_state.winner == :player_1

    {:ok, final_state} = Game.play(name, :player_1, {0, 2})

    assert final_state.board == [
      [%TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: :player_1}, %TicTacToe.Board{player: :player_1}],
      [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}],
      [%TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}, %TicTacToe.Board{player: nil}]
    ]
    assert final_state.winner == :player_1
  end

end
