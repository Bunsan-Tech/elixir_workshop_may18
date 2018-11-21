defmodule PragmaticBookshelf do
  @moduledoc """
   Módulo para determinar los impuestos  de las ordenes por  estado
  """

  @tax_rates  [ NC: 0.075, TX: 0.08 ]

  @orders [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

@doc """
    Función que recorre la lista de ordernes de compra

    ## Examples
    iex> PragmaticBookshelf.total()
    #[
      [[total_amount: 107.5], {:id, 123}, {:ship_to, :NC}, {:net_amount, 100.0}],
      [[total_amount: 0], {:id, 124}, {:ship_to, :OK}, {:net_amount, 35.5}],
      [[total_amount: 25.92], {:id, 125}, {:ship_to, :TX}, {:net_amount, 24.0}],
      [[total_amount: 48.384], {:id, 126}, {:ship_to, :TX}, {:net_amount, 44.8}],
      [[total_amount: 26.875], {:id, 127}, {:ship_to, :NC}, {:net_amount, 25.0}],
      [[total_amount: 0], {:id, 128}, {:ship_to, :MA}, {:net_amount, 10.0}],
      [[total_amount: 0], {:id, 129}, {:ship_to, :CA}, {:net_amount, 102.0}],
      [[total_amount: 53.75], {:id, 120}, {:ship_to, :NC}, {:net_amount, 50.0}]
    ]

  """
 def total() do
    Enum.map(@orders, &add_tax/1)
 end

 defp add_tax(order) do
   rate = rate(order)
   total = order[:net_amount] *rate + order[:net_amount]
   List.insert_at(order, 0, total_amount: total)
 end

 defp rate(order) do
  case  order[:ship_to] do
    :NC ->
       @tax_rates[:NC]

    :TX ->
      @tax_rates[:TX]

      _ ->
       0
   end

 end

end
