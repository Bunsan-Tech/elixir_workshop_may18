defmodule JorgeTest do
  use ExUnit.Case
  doctest Jorge

  test "greets the world" do
    assert Jorge.hello() == :world
  end
end
