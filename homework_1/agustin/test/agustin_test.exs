defmodule AgustinTest do
  use ExUnit.Case
  doctest Agustin

  test "greets the world" do
    assert Agustin.hello() == :world
  end

  test "count words" do
    assert %{"one" => 1, "fish" => 4, "two" => 1, "red" => 1, "blue" => 1} ==
             WordCount.count("one fish two fish red fish blue fish")
  end

  test "print count" do
    text = "one fish two fish red fish blue fish"

    text
    |> WordCount.count()
    |> WordCount.print()
  end
end
