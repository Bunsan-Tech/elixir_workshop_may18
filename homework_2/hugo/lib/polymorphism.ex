defmodule Polymorphism do

  defimpl Enumerable, for: BitString do
    def member?(bitstring, char) do
      bitstring_list = for <<x::binary-1 <- bitstring>>, do: x
      {:ok, Enum.member?(bitstring_list, char)}
    end

    def count(bitstring) do
      bitstring_list = for <<x::binary-1 <- bitstring>>, do: x
      {:ok, Enum.count(bitstring_list)}
    end

    def slice(_) do
      {:error, __MODULE__}
    end

    def reduce(_, {:halt, acc}, _fun), do: {:halted, acc}
    def reduce([h | t], {:suspend, acc}, fun) do
      {:suspended, acc, &reduce([h | t], &1, fun)}
    end
    def reduce(bitstring, {:suspend, acc}, fun) do
      bitstring_list = for <<x::binary-1 <- bitstring>>, do: x
      reduce(bitstring_list, {:suspend, acc}, fun)
    end
    def reduce([],      {:cont, acc}, _fun),   do: {:done, acc}
    def reduce([h | t], {:cont, acc}, fun),    do: reduce(t, fun.(h, acc), fun)

    def reduce(bitstring, {:cont, acc}, fun) do
      bitstring_list = for <<x::binary-1 <- bitstring>>, do: x
      reduce(bitstring_list, {:cont, acc}, fun)
    end
  end

end
