defmodule IvanhoeTest do
  use ExUnit.Case
  doctest Ivanhoe

  test "greets the world" do
    assert Ivanhoe.hello() == :world
  end
end
