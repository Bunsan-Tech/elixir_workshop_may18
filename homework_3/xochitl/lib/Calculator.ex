defmodule Calculator do

  def start do
    spawn(fn -> loop(0) end)
  end

  defp loop(val) do
    new_val =
      receive do
        {:add, n} -> val + n
        {:sub, n} -> val - n
        {:mul, n} -> val * n
        {:div, n} -> val / n
        {:value, caller} ->
          send caller, {:value, val}
          val
          # code
      end
      loop(new_val)
  end

  def add(pid, n), do: send pid, {:add, n}
  def sub(pid, n), do: send pid, {:sub, n}
  def mul(pid, n), do: send pid, {:mul, n}
  def div(pid, n), do: send pid, {:div, n}

  def value(pid) do
    send pid, {:value, self()}
    receive do
      {:value, val} -> val
      after 5000 -> {:error, :no_value}
    end
  end
  
end