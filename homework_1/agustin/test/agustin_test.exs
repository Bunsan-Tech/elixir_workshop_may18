defmodule AgustinTest do
  use ExUnit.Case
  doctest Agustin

  test "greets the world" do
    assert Agustin.hello() == :world
  end

  test "calculate tax" do
    order = [id: 123, ship_to: :NC, net_amount: 100.00]
    tax_rates = [NC: 0.075, TX: 0.08]

    assert [total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.00] ==
             PragmaticBookshelf.tax_for_order(order, tax_rates)
  end

  test "calculate all taxes" do
    tax_rates = [NC: 0.075, TX: 0.08]

    orders = [
      [id: 123, ship_to: :NC, net_amount: 100.00],
      [id: 124, ship_to: :OK, net_amount: 35.50],
      [id: 125, ship_to: :TX, net_amount: 24.00],
      [id: 126, ship_to: :TX, net_amount: 44.80],
      [id: 127, ship_to: :NC, net_amount: 25.00],
      [id: 128, ship_to: :MA, net_amount: 10.00],
      [id: 129, ship_to: :CA, net_amount: 102.00],
      [id: 120, ship_to: :NC, net_amount: 50.00]
    ]

    results = [
      [total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.0],
      [total_amount: 35.5, id: 124, ship_to: :OK, net_amount: 35.5],
      [total_amount: 25.92, id: 125, ship_to: :TX, net_amount: 24.0],
      [total_amount: 48.384, id: 126, ship_to: :TX, net_amount: 44.8],
      [total_amount: 26.875, id: 127, ship_to: :NC, net_amount: 25.0],
      [total_amount: 10.0, id: 128, ship_to: :MA, net_amount: 10.0],
      [total_amount: 102.0, id: 129, ship_to: :CA, net_amount: 102.0],
      [total_amount: 53.75, id: 120, ship_to: :NC, net_amount: 50.0]
    ]

    assert results == PragmaticBookshelf.calculate_tax(orders, tax_rates)
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
