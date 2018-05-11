defmodule TicTacToe do

def start_link do
		board = %{
	  	0 => %{0 => " ", 1 => " ", 2 => " "},
	  	1 => %{0 => " ", 1 => " ", 2 => " "},
	  	2 => %{0 => " ", 1 => " ", 2 => " "}
		}
    current_player = :player_1
  spawn (fn -> loop(board, current_player) end)
end

def loop(board, current_player) do
  {current_player, current_board} = 
    receive do
      # {:player_1, {row, column}, caller} -> if :player_1 == current_player, do: put_in(board[row][column], "x"), else: {:error, "ist's not your turn!"}
      {:player_1, {row, column}, caller} ->
        if :player_1 == current_player do
          move(:player_1, board, {row, column}, caller)
        else
          send caller, {:error, "ist's not your turn!"}
          {current_player, board}
        end   
      {:player_2, {row, column}, caller} ->
        if :player_2 == current_player  do
          move(:player_2, board, {row, column}, caller)
        else
          send caller, {:error, "ist's not your turn!"}
          {current_player, board}
        end
    end

  loop(current_board,current_player)
end

def move(current_player, board,{row, column}, caller) do
  case current_player do
     :player_1 -> 
        if board[row][column] == " " do
          current_board = put_in(board[row][column], "X")
          cond do
            is_winner(current_board, "X") ->
              send caller, {:winner, current_board}
            is_winner(current_board, "X") != true ->
              send caller, {:update_board, current_board}
              {:player_2 , current_board}
          end
        else
          send caller, {:error, " the box is already occupied"}
          {:player_1, board}
        end

     :player_2 ->
        if board[row][column] == " " do
          current_board = put_in(board[row][column], "O")
          cond do
            is_winner(current_board, "O") ->
              send caller, {:winner, current_board}
            is_winner(current_board, "O") != true ->
              send caller, {:update_board, current_board}
              {:player_1 , current_board}
          end
        else
          send caller, {:error, " the box is already occupied"}
          {:player_2, board}
        end
  end
end

def is_winner(board, current_player_symbol) do

  cond do 
    #rows
    board[0][0] == current_player_symbol and board[0][1]== current_player_symbol and board[0][2] == current_player_symbol-> true
    board[1][0] == current_player_symbol and board[1][1]== current_player_symbol and board[1][2] == current_player_symbol -> true
    board[2][0] == current_player_symbol and board[2][1]== current_player_symbol and board[2][2] == current_player_symbol -> true
    # columns
    board[0][0] == current_player_symbol and board[1][0]== current_player_symbol and board[2][0] == current_player_symbol-> true
    board[0][1] == current_player_symbol and board[1][1]== current_player_symbol and board[2][1] == current_player_symbol -> true
    board[0][2] == current_player_symbol and board[1][2]== current_player_symbol and board[2][2] == current_player_symbol -> true
    #diagonal
    board[0][0] == current_player_symbol and board[1][1]== current_player_symbol and board[2][2] == current_player_symbol -> true
    board[0][2] == current_player_symbol and board[1][1]== current_player_symbol and board[2][1] == current_player_symbol -> true
    true ->
      false    
  end

  
end

  # def play(pid, :player_1, {row, column}), do: send pid, {:player_1, {row, column},self()}
  # def play(pid, :player_2, {row, column}), do: send pid, {:player_2, {row, column},self()}

  def play(pid, :player_1, {row, column}) do
    send pid, {:player_1, {row, column}, self()}
    receive do
      {:update_board, board} ->   
      IO.puts "|#{board[0][0]}|#{board[0][1]}|#{board[0][2]}|
|#{board[1][0]}|#{board[1][1]}|#{board[1][2]}|
|#{board[2][0]}|#{board[2][1]}|#{board[2][2]}|"
      {:winner,board} -> 
      IO.puts "|#{board[0][0]}|#{board[0][1]}|#{board[0][2]}|
|#{board[1][0]}|#{board[1][1]}|#{board[1][2]}|
|#{board[2][0]}|#{board[2][1]}|#{board[2][2]}|"
      IO.puts "You Win player 2"
      {:error, message} -> IO.puts message
      after 5000 -> {:error, :no_value}
    end
    
  end

  def play(pid, :player_2, {row, column}) do
    send pid, {:player_2, {row, column}, self()}
    receive do
      {:update_board, board} -> 
      IO.puts "|#{board[0][0]}|#{board[0][1]}|#{board[0][2]}|
|#{board[1][0]}|#{board[1][1]}|#{board[1][2]}|
|#{board[2][0]}|#{board[2][1]}|#{board[2][2]}|"
      {:winner,board} -> 
      IO.puts "|#{board[0][0]}|#{board[0][1]}|#{board[0][2]}|
|#{board[1][0]}|#{board[1][1]}|#{board[1][2]}|
|#{board[2][0]}|#{board[2][1]}|#{board[2][2]}|"
      IO.puts "You Win player 2"
      {:error, message} -> IO.puts message
      after 5000 -> {:error, :no_value}
    end
    
  end

 def value(pid) do
    send pid, {:value, self()}
    receive do
      {:value, board} -> board
      after 5000 -> {:error, :no_value}
    end
  end

end
