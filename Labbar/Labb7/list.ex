defmodule Functions do

  def take([], _) do
    []
  end
  def take(_, 0) do
      []
  end
  def take([h | t], n) do
      [h | take(t, n-1)]
  end

  def takelast(xs, n) do
    drop(xs, Enum.count(xs)-n)
  end

  def drop([], _) do
    []
  end
  def drop(xs, 0) do
    xs
  end
  def drop([_ | t], n) do
    drop(t, n-1)
  end

  def append(xs, []) do
    xs
  end
  def append(xs, [h | t]) do
    append(xs ++ [h], t)
  end

  def member([], _) do
    false
  end
  def member([h | t], y) do
    cond do
      y == h -> true
      true -> member(t, y)
    end
  end

  def position(xs, y) do
    position(xs, y, 0)
  end
  def position([h | t], y, i) do
    cond do
      y == h -> i + 1
      true -> position(t, y, i+1)
    end
  end

end
