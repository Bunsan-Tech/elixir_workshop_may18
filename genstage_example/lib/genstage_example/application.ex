defmodule GenstageExample.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {GenstageExample.Producer, 0},
      {GenstageExample.ProducerConsumer, []},
      {GenstageExample.Consumer, []}
    ]

    opts = [strategy: :one_for_one, name: GenstageExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
