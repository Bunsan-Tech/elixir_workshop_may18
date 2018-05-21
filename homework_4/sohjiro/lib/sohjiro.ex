defmodule Sohjiro do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      { Registry, keys: :unique, name: Registry.TicTacToe },
			TicTacToe.GameSupervisor
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
