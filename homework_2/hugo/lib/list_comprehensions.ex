defmodule ListComprehensions  do
# @size 1..10
#  @perimeter 24

#  def triangles do
#    sides = for a <-  @size, b <-  @size, c <-  @size, do: a + b + c == @perimeter, do: Enum.sort([a, b, c])
#    Enum.uniq(sides)

#    IO.puts "Triangulos con perimetro <= 24"
#    IO.inspect sides, charlists: :as_lists
#  end

  @perimeter 24
  @range 0..10
  def problem_one do
    sides = gen_sides()
    |> Enum.uniq

    IO.puts "Lados con los que se obtiene el perimetro requerido"
    IO.inspect sides, charlists: :as_lists
    :ok
  end

  def gen_sides() do
    for a <- @range,
        b <- @range,
        c <- @range,
        a + b + c == @perimeter and
        (a * a + b * b) == c * c,
        do: Enum.sort [a, b, c]
  end

end


