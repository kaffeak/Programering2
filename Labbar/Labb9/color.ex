defmodule Color do

  def convert(depth, max) do
    a = (depth/max)*10
    x = trunc(a)
    y = trunc(255*(a-x))
    case x do
      0 -> {:rgb ,y, 0, 0}
      1 -> {:rgb ,255, y, 0}
      2 -> {:rgb ,255 - y, 255, 0}
      3 -> {:rgb ,0, 255, y}
      4 -> {:rgb ,0, 255 - y, 255}
      5 -> {:rgb ,0, 255 - y, 255}
      6 -> {:rgb ,0, 0, y}
      7 -> {:rgb ,0, y, 255}
      8 -> {:rgb ,0, 255, 255-y}
      9 -> {:rgb ,y , 255, 0}
      10 ->{:rgb ,y, 0, 255}
    end
  end

  def truncate(a) do
    cond do
      a < 0.5 -> 0
      a < 1.5 && a >= 0.5 -> 1
      a < 2.5 && a >= 1.5 -> 2
      a < 3.5 && a >= 2.5 -> 3
      a >= 3.5 -> 4
    end
  end

end
