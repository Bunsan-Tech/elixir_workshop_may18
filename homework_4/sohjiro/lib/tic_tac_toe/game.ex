defmodule TicTacToe.Game do
  use GenServer
  alias TicTacToe.{Board, Display, Rules, Winner}

  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: via_tuple(name))
  end

  def init([]) do
    game_state = %{turn: :player_1, board: Board.new(), winner: nil}
    {:ok, game_state}
  end

  def via_tuple(name), do: {:via, Registry, {Registry.TicTacToe, name}}

  def play(name, player, position) do
    GenServer.call(via_tuple(name), {player, position})
  end

  def handle_call({player, position}, _from, game_state) do
    game_state
    |> mark_board_for(player, position)
    |> handle_response(game_state)
  end

  def handle_response({:ok, new_board}, game_state) do
    turn_for_player = next_turn(game_state.turn)

    game_state
    |> assign_winner(new_board)
    |> update_game_state(new_board, turn_for_player)
    |> reply_success(:ok)
  end

  def handle_response({:error, :game_over}, game_state) do
    {:stop, :normal, {:ok, game_state}, game_state}
  end

  def handle_response(message, game_state) do
    {:reply, message, game_state}
  end

  defp reply_success(game_state, status) do
    {:reply, {status, game_state}, game_state}
  end

  def assign_winner(game_state, new_board) do
    case Winner.win?(new_board) do
      true -> %{game_state | winner: game_state.turn}
      false -> game_state
    end
  end

  defp update_game_state(game_state, new_board, next_turn) do
    game_state
    |> Map.put(:turn, next_turn)
    |> Map.put(:board, new_board)
  end

  defp mark_board_for(game_state, player, position) do
    with :ok <- Rules.verify_winner(game_state.winner),
         :ok <- Rules.verify_turn_for_player(game_state.turn, player),
         :available <- Rules.verify_square_available(game_state.board, position)
    do
      {:ok, Board.mark_square(game_state.board, player, position)}
    else
      :game_over -> {:error, :game_over}
      :error -> {:error, "It's not your turn!"}
      :not_available -> {:error, "Square is not available"}
    end
  end

  defp next_turn(:player_1), do: :player_2
  defp next_turn(:player_2), do: :player_1

end
