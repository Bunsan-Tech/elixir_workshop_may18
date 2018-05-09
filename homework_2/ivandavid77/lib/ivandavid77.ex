defmodule Ivandavid77 do
  @moduledoc """
  Documentation for Ivandavid77.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ivandavid77.hello
      :world

  """
  def hello do
    :world
  end

  def problem_1 do
    params = [
      required_perimeter: 24,
      range_of_length: 1..10
    ]
    sides = get_triangle_sides(params)
    IO.puts "Lados con los que se obtiene el perimetro requerido"
    IO.inspect sides, charlists: :as_lists
    nil
  end

  def get_triangle_sides(required_perimeter: perimeter, range_of_length: range) do
    sides = for a <- range, b <- range, c <- range, a + b + c == perimeter, do: Enum.sort([a, b, c])
    Enum.uniq(sides)
  end

  # ----------------------------------------------------------------------------------------

  def problem_2 do
    prime_generator = get_prime_generator()
    Enum.take(prime_generator, 20)
  end

  def get_prime_generator do
    Stream.iterate(1, &get_next_prime/1)
  end

  def get_next_prime(previous_number) do
    current_number = previous_number + 1
    can_divide_current_number = fn num -> if rem(current_number, num) == 0 do 1 else 0 end end
    sum = Enum.map(2..current_number, can_divide_current_number) |> Enum.sum
    if sum == 1 do
      current_number
    else
      get_next_prime(current_number)
    end
  end

  # -----------------------------------------------------------------------------------------

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


