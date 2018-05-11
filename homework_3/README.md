## Problem 1 - Tic Tac Toe Server

Implement a simple server to play a the tic-tac-toe game.
The API of the module should be as follows.

```elixir
iex> {:ok, server_pid} = TicTacToe.start_link

iex> TicTacToe.play(server_pid, :player_1, {1, 1})
| | | |
| |x| |
| | | |
{:ok, "game is on!"}

iex> TicTacToe.play(server_pid, :player_1, {0, 0})
{:error, "ist's not your turn!"

iex> TicTacToe.play(server_pid, :player_2, {0, 0})
|o| | |
| |x| |
| | | |
{:ok, "game is on!"}

...
...

iex> TicTacToe.play(server_pid, :player_1, {0, 2})
|o|o|x|
| |x| |
|x| | |

{:ok, "Player_1 wins!"}
```

Do not use OTP behaviours.

## Problem 2 - Round robin pool

Using integers as identifiers of connections and an Agent for storing state,
implement a connection pool that gives you a connection in a round robin fashion.

```elixir
iex> ConnectionPool.init(3)
iex> ConnectionPool.get_connection()
1
iex> ConnectionPool.get_connection()
2
iex> ConnectionPool.get_connection()
3
iex> ConnectionPool.get_connection()
1
iex> ConnectionPool.get_connection()
2
```




