defmodule TicTacToeLib do
  def initialize() do
    reset_state()
  end

  @doc """
  El jugador realiza un movimiento
  returns
  {{:ok, :game_on}, new_state}
  {{:ok, {:win, :player_1 | :player_2}}, new_state}
  {{:ok, :draw}, new_state}
  {{:error, :invalid_turn}, state}
  {{:error, :invalid_movement}, state}
  {{:error, :invalid_player}, state}
  """
  def play(player, row, col, state) do
    # El jugador es valido?
    if is_valid_player?(player, get_players(state)) do
      # El jugador actual fue el ultimo en jugar?
      if get_last_movement_from(state) == player do
        reply(:error, :invalid_turn, state)
      else
        # El movimiento es valido?
        if is_valid_movement?(row, col, get_board(state)) do
          new_board = add_movement(player, row, col, get_board(state))
          {msg, new_state} = case make_veredict(new_board) do
            :win     -> { {:win, player}, reset_state() }
            :draw    -> { :draw, reset_state() }
            :game_on -> { :game_on, update_state(state, new_board, player) }
          end
          reply(:ok, msg, new_state)
        else
          # El movimiento no es valido
          reply(:error, :invalid_movement, state)
        end
      end
    else
      # El jugador no es valido
      reply(:error, :invalid_player, state)
    end
  end

  defp is_valid_movement?(row, col, board) do
    row in 0..2 and col in 0..2 and not List.keymember?(board, {row, col}, 1)
  end

  defp is_valid_player?(player, players) do
    Enum.member?(players, player)
  end

  defp is_winner?(player, board) do
    if length(board) < 5 do
      false
    else
      board
        |> Enum.filter(fn {p, _} -> p == player end)
        |> Enum.map(fn {_, {row, col}} -> {row, col} end)
        |> have_winner_combination?
    end
  end

  defp have_winner_combination?(board) do
    board_set = MapSet.new(board)
    ms = fn list -> MapSet.new(list) end
    (MapSet.subset?(ms.([{0,0}, {0,1}, {0,2}]), board_set) or # Horizontales
     MapSet.subset?(ms.([{1,0}, {1,1}, {1,2}]), board_set) or
     MapSet.subset?(ms.([{2,0}, {2,1}, {2,2}]), board_set) or
     MapSet.subset?(ms.([{0,0}, {1,0}, {2,0}]), board_set) or # Verticales
     MapSet.subset?(ms.([{0,1}, {1,1}, {2,1}]), board_set) or
     MapSet.subset?(ms.([{0,2}, {1,2}, {2,2}]), board_set) or
     MapSet.subset?(ms.([{0,0}, {1,1}, {2,2}]), board_set) or # diagonales
     MapSet.subset?(ms.([{0,2}, {1,1}, {2,0}]), board_set))
  end

  defp is_draw?(board) do
    length(board) == 9
  end

  defp make_veredict(board) do
    [{player, _} | _] = board
    if is_winner?(player, board) do
      :win
    else
      if is_draw?(board) do
        :draw
      else
        :game_on
      end
    end
  end

  defp add_movement(player, row, col, board) do
    [{player, {row, col}} | board]
  end

  defp reply(type, msg, state) do
    { {type, msg}, state }
  end

  defp reset_state() do
    board = []
    players = [:player_1, :player_2]
    last_movement_from = :player_2
    {board, players, last_movement_from}
  end

  def get_board({board, _, _}) do
    board
  end

  def get_players({_, players, _}) do
    players
  end

  def get_last_movement_from({_, _, last_movement_from}) do
    last_movement_from
  end

  defp update_state(state, board, last_movement_from) do
    {board, get_players(state), last_movement_from}
  end
end
