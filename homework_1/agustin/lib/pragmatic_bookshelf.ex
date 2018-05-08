defmodule PragmaticBookshelf do
  def calculate_tax(orders, tax_rates) do
    Enum.map(orders, fn order ->
      tax_for_order(order, tax_rates)
    end)
  end

  def tax_for_order(order, tax_rates) do
    state = Keyword.get(order, :ship_to)
    tax = Keyword.get(tax_rates, state, 0)
    amount = Keyword.get(order, :net_amount)
    total = amount + amount * tax
    Keyword.put(order, :total_amount, total)
  end
end
