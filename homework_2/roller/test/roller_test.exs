defmodule RollerTest do
  use ExUnit.Case
  doctest Roller

  test "greets the world" do
    assert Roller.hello() == :world
  end
end
