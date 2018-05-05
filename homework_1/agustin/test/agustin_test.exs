defmodule AgustinTest do
  use ExUnit.Case
  doctest Agustin

  test "greets the world" do
    assert Agustin.hello() == :world
  end
end
