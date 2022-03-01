defmodule Labb6 do

  def test() do
    depth(Day1.input(), 0)
  end
  #def depth([h | t]) do
  #  depth(t, h,0)
  #end
  def depth([prev , h | []], i) do
    cond do
      h > prev -> i+1
      true -> i
    end
  end
  def depth([prev, h | t], i) do
    cond do
      h > prev -> depth([h | t], i+1)
      true -> depth([h | t], i)
    end
  end

  def test2() do
    depth(three_depth(Day1.input()), 0)
  end
  def three_depth([first, second, third | []]) do
    [first+second+third]
  end
  def three_depth([first, second, third | t]) do
    [first+second+third | three_depth([second, third | t])]
  end

end
