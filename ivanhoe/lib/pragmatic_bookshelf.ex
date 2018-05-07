defmodule PragmaticBookshelf do

  @tax_rates [ NC: 0.075, TX: 0.08 ]

  @orders [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

  def list_with_tax() do
    Enum.map(@orders, &apply_tax/1)
  end

  def apply_tax(order) do
    rate_per_state = find_rate(order[:ship_to])
    total_amount = order[:net_amount] + rate_per_state
    order ++ [total_amount: total_amount]
  end

  def find_rate(_value = :NC), do: @tax_rates[:NC]
  def find_rate(_value = :TX), do: @tax_rates[:TX]
  def find_rate(_value = _), do: 0.0


end
