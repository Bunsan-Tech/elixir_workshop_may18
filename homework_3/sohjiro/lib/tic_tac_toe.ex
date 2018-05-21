defmodule TicTacToe do
  @size 3
  @player_marks %{player_1: "x", player_2: "o"}

  def start_link() do
    {:ok, spawn(fn -> init() end)}
  end

  defp init do
    initial_state = 1..9
    |> Enum.map(&new(&1))
    |> Enum.chunk_every(@size)

    board = %{turn: :player_1, state: initial_state, winner: nil}
    loop(board)
  end

  defp new(_number), do: %{mark: " ", player: nil}

  defp loop(board) do
    receive do
      {caller, player, position} ->
        board
        |> mark_board_for(player, position)
        |> handle_response(board, caller)
      _ ->
        loop(board)
    end
  end

  defp handle_response({:ok, new_board}, game_state, caller) do
    turn_for_player = next_turn(game_state.turn)

    game_state
    |> assign_winner(new_board)
    |> update_board(new_board, turn_for_player)
    |> reply_success(caller)
  end

  defp handle_response(message, board, caller) do
    send(caller, message)
    loop(board)
  end

  def assign_winner(game_state, new_board) do
    case winner?(new_board) do
      true -> %{game_state | winner: game_state.turn}
      false -> game_state
    end
  end

  defp print_board(board) do
    Enum.each(board.state, fn columns ->
      print_row(columns)
    end)
    board
  end

  defp print_row(columns),
    do: :io.fwrite("|~3.2s|~3.2s|~3.2s|~n", Enum.map(columns, &(&1.mark)))

  defp reply_success(game_state, caller) do
    case is_nil(game_state.winner) do
      true ->
        send(caller, {:ok, "game is on!"})
        game_state
        |> print_board
        |> loop
      false ->
        winner = game_state.winner |> Atom.to_string |> String.capitalize
        send(caller, {:ok, "Game over : #{winner} wins!"})
        print_board(game_state)
    end
  end

  defp next_turn(:player_1), do: :player_2
  defp next_turn(:player_2), do: :player_1

  defp mark_board_for(board, player, position) do
    with :ok <- verify_turn_for_player(board.turn, player),
         :available <- verify_square_available(board.state, position) do
      {:ok, mark_square(board, player, position)}
    else
      :error -> {:error, "ist's not your turn!"}
      :not_available -> {:error, "Square not available"}
    end
  end

  defp update_board(game_state, new_board, next_turn) do
    game_state
    |> Map.put(:turn, next_turn)
    |> Map.put(:state, new_board)
  end

  defp verify_square_available(state, {row, col}) do
    square = state
             |> Enum.at(row)
             |> Enum.at(col)

    case is_nil(square.player) do
      true -> :available
      false -> :not_available
    end
  end

  defp verify_turn_for_player(turn, player) do
    case turn == player do
      true -> :ok
      false -> :error
    end
  end

  defp mark_square(board, player, position) do
    board.state
    |> List.flatten
    |> Stream.with_index
    |> Stream.map(&mark_with_position(&1, player, position))
    |> Enum.chunk_every(@size)
  end

  defp mark_with_position({square, index}, player, coordinate) do
    case valid?(index, coordinate) do
      true ->
        mark = Map.get(@player_marks, player)
        %{mark: mark, player: player}
      false -> square
    end
  end

  defp valid?(index, coordinate), do: index?(index, coordinate)
  defp index?(index, coordinate), do: index == calculate_index(coordinate)
  defp calculate_index({row, column}), do: row * @size + column

  def play(pid, player, position) do
    send(pid, {self(), player, position})
      receive do
        msg -> msg
        after 5_000 -> IO.puts "Game is over"
      end
  end

  defp winner?(new_board) do
    new_board
    |> possible_winning_square_sequences()
    |> sequences_with_at_least_one_square_marked()
    |> Enum.map(&all_squares_marked_by_same_player?(&1))
    |> Enum.any?()
  end

  defp possible_winning_square_sequences(squares) do
    squares ++
    transpose(squares) ++
    [left_diagonal_squares(squares), right_diagonal_squares(squares)]
  end

  defp transpose(squares) do
    squares
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def rotate_90_degrees(squares) do
    squares
    |> transpose()
    |> Enum.reverse()
  end

  def left_diagonal_squares(squares) do
    squares
    |> List.flatten()
    |> Enum.take_every(Enum.count(squares) + 1)
  end

  def right_diagonal_squares(squares) do
    squares
    |> rotate_90_degrees()
    |> left_diagonal_squares()
  end

  def sequences_with_at_least_one_square_marked(squares) do
    Enum.reject(squares, fn sequence ->
      Enum.reject(sequence, &is_nil(&1.player)) |> Enum.empty?()
    end)
  end

  def all_squares_marked_by_same_player?(squares) do
    first_square = Enum.at(squares, 0)

    Enum.all?(squares, fn s ->
      s.player == first_square.player
    end)
  end

end
