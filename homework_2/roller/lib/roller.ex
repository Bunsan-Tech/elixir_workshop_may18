defmodule Roller do
  @moduledoc """
  Documentation for Roller.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Roller.hello
      :world

  """
  def hello do
    :world
  end

  # =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
  # Problem 1 - List comprehensions
  # Which right triangle that has integers for all sides and all sides equal
  # to or smaller than 10 has a perimeter of 24?
  # =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
  @perimeter 24
  @range 0..10
  def problem_one do
    all_sides = gen_sides()
    |> Enum.uniq
    |> Enum.with_index

    IO.inspect "Side`s Triangle " <> inspect(all_sides, charlists: :as_lists)
    :ok
  end

  def gen_sides() do
    for a <- @range,
        b <- @range,
        c <- @range,
        a + b + c == @perimeter,
        into: [],
        do: Enum.sort [a, b, c]
  end

  # =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
  # Problem 2 - Infinite primes
  # Create a stream that generates all the prime numbers, so you can take the 1st
  # n primes form it using `Enum.take/2`
  # =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
  def problem_two do
    Stream.iterate(2, &gen_prime(&1 + 1))
    |> Enum.take(10)
  end

  defp gen_prime(number) do
    case is_prime(number) do
      :true -> number
      :false -> gen_prime(number + 1)
    end
  end

  defp is_prime(number) when number == 3, do: :true
  defp is_prime(number) do
    range = number
    |> :math.sqrt
    |> Float.floor
    |> round

    !Enum.any?(2..range, &(rem(number, &1) == 0))
  end

  # =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
  # Problem 3 - Polymorphism
  # Create an implementation of `Enumerable` for binary strings, such that
  # you can manipulate each character in a string with Enum.each/2.
  # =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
  def problem_three do
  end  
end
