defmodule LauraTest do
  use ExUnit.Case
  doctest Laura

  test "greets the world" do
    assert Laura.hello() == :world
  end
end
