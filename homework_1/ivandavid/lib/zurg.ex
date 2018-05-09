defmodule Zurg do

  def run do
    inside_zurg = [buzz: 5, woody: 10, rex: 20, hamm: 25]
    outside_zurg = []
    flashlight_minutes = 60
    history = []
    return(inside_zurg, outside_zurg, flashlight_minutes, history)
    :nil
  end

  def escape([], _, flashlight_minutes, history) when flashlight_minutes >= 0 do
    # Si ya no hay nadie en zurg, hemos terminado
    IO.puts "Minutes left: #{flashlight_minutes}, Movement history:"
    IO.inspect Enum.reverse(history) # historia en el orden en que sucedieron las cosas
  end

  def escape(inside_zurg, outside_zurg, flashlight_minutes, history) when flashlight_minutes >= 0  do
    # Ahora la lampara esta afuera de zurg, un juguete valiente debe tomar la lampara y regresar por el resto
    for brave_toy <- outside_zurg do
      time_to_cross = elem(brave_toy, 1)
      updated_history = [ {:return, [brave_toy]} | history ]
      return([ brave_toy | inside_zurg ], outside_zurg -- [brave_toy], flashlight_minutes - time_to_cross, updated_history)
    end
  end

  def escape(_, _, _, _) do

  end

  def return(inside_zurg, outside_zurg, flashlight_minutes, history) when flashlight_minutes >= 0 do
    # Ahora la lampara esta en zurg de nuevo, debe escapar otro par de juguetes
    for toy_1 <- inside_zurg, toy_2 <- inside_zurg, toy_1 != toy_2 do
      time_to_cross = max(elem(toy_1, 1), elem(toy_2, 1)) # El juguete mas veloz se ajusta a la velocidad del menos veloz
      updated_history = [ {:escape, [toy_1, toy_2]} | history ]
      escape(inside_zurg -- [toy_1, toy_2], outside_zurg ++ [toy_1, toy_2], flashlight_minutes - time_to_cross, updated_history)
    end
  end

  def return(_, _, _, _) do

  end
end
