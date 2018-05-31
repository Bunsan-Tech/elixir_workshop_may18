defmodule WordCount do

  def run(text) do
    paragraph = prepare(text)
    count_words(paragraph, Map.new)
  end

  defp count_words([], acc), do: acc

  defp count_words([head | tail], acc) do
    quantity = Map.get(acc, head, 0)
    acc = Map.put(acc, head, quantity + 1)
    count_words(tail, acc)
  end

  defp prepare(text) do
    text
    |> String.downcase
    |> String.split
  end

end
