defmodule WordCount do
  def run(text) do
    opts = [:global,  {:return, :list}]
    # Obtener un listado de palabras (no números)
    word_list = text
      |> :re.replace("[^A-Za-z ]", " ", opts)
      |> :re.replace("\\s+", " ", opts)
      |> to_string # Remueve errores en windows
      |> String.trim
      |> String.downcase
      |> String.split
    # Contar las palabras
    word_frequency_list = word_list
      |> List.foldl(%{}, fn word, acc -> Map.update(acc, word, 1, &(&1 + 1)) end)
      |> Map.to_list
    # Mostrar conteo de palabras
    my_fun = fn {word, count} -> IO.puts("#{word}: #{count}") end
    Enum.each(word_frequency_list, my_fun)
  end
end
