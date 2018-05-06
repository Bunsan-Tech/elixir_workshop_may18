defmodule Wordcount do
  @moduledoc """
   Módulo para contar las palabras de una texto
  """

  @doc """
    Función para obtener las palabras del texto dntro de una lista

  """
  def count_words(text) do
    text
    |> String.split()
    |> count()

  end

   @doc """
    Función para contabilizar las palabras repetidas en la lista

  """
  def count(words_list) when is_list(words_list) do
    Enum.reduce(words_list, %{}, &update_count/2)
  end

  @doc """
    Función para actualizar  el conteo  las palabras repetidas en la lista

  """
  def update_count(word, acc) do
    Map.update(acc, String.to_atom(word), 1, &(&1 + 1))
  end

end

