defmodule TicTacToeBehavior do
  # Para probar behaviors de Elixir
  @callback start_link() :: {:ok, pid()} | {:error, any()}
  @callback play(pid(), atom(), {pos_integer(), pos_integer()}) :: {:ok, any()} | {:error, any()}
end
