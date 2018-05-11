defmodule HugoTest do
  use ExUnit.Case
  doctest Hugo

  test "greets the world" do
    assert Hugo.hello() == :world
  end
end
