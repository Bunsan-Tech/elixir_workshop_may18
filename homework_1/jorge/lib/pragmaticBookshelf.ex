defmodule PragmaticBookshelf do
  @moduledoc """
  This module is for thw 1st homework
  """

  @doc """
  Function for to get list with taxes
  """
  def getOrdersWithTaxes(list) do
    Enum.map(list, fn(x) -> addTaxes(x) end)
  end

  defp addTaxes(kList) do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    if kList[:ship_to] == :NC do
      kList ++ [amount: kList[:net_amount] + ( kList[:net_amount] * tax_rates[:NC] )]
    else if kList[:ship_to] == :TX do
      kList ++ [amount: kList[:net_amount] + ( kList[:net_amount] * tax_rates[:NC] )]
    else
      kList
      end
    end
  end
end