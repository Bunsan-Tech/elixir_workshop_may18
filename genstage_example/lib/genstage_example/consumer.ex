defmodule GenstageExample.Consumer do
  use GenStage

  def start_link(_) do
    GenStage.start_link(__MODULE__, :state_doesnt_matter)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [GenstageExample.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    IO.puts "Consumer handling #{length(events)} events"
    for event <- events do
      IO.inspect({self(), event, state})
    end
    # As a consumer we never emit events
    {:noreply, [], state}
  end
end
