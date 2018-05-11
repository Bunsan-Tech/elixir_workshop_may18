defmodule InfinitePrimes do

  def primes(n) do
  2..n
    |> Stream.filter(&prime?/1)
    |> Enum.take(n)
 end

  def prime?(x)  do
    (2..x
    |> Enum.filter(fn a -> rem(x, a) == 0 end) |> length()) == 1
  end

  # Charangas
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

  # Ivan David

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

end
