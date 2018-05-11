defmodule SohjiroTest do
  use ExUnit.Case
  doctest Sohjiro

  test "greets the world" do
    assert Sohjiro.hello() == :world
  end
end
