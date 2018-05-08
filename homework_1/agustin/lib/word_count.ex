defmodule WordCount do
  def count(text) do
    text
    |> String.split()
    |> Enum.reduce(%{}, fn word, map ->
      if Map.has_key?(map, word) do
        Map.put(map, word, Map.get(map, word) + 1)
      else
        Map.put(map, word, 1)
      end
    end)
  end

  def print(map_count) do
    Enum.each(map_count, fn {word, times} ->
      IO.puts("#{word} --> #{times}")
    end)
  end
end
