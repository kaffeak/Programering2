defmodule Shunt do

  def find([], []) do
    []
  end
  def find(xs, [hy | ty]) do
    {l1, l2} = split(xs, hy)
    [{:one, Enum.count(l2)+1}, {:two, Enum.count(l1)}, {:one, -1*(Enum.count(l2)+1)}, {:two, -1*Enum.count(l1)} | find(Functions.append(l2, l1), ty)]
  end

  def few([], []) do
    []
  end
  def few([hx | tx], [hy | ty]) do
    {l1, l2} = split([hx | tx], hy)
    cond do
      hx == hy -> few(tx, ty)
      true -> [{:one, Enum.count(l2)+1}, {:two, Enum.count(l1)}, {:one, -1*(Enum.count(l2)+1)}, {:two, -1*Enum.count(l1)} | few(Functions.append(l2, l1), ty)]
    end
  end

  def split(list, y) do
    {Functions.take(list, Functions.position(list, y)-1), Functions.drop(list, Functions.position(list, y))}
  end

  def rules([]) do
    []
  end
  def rules([{_ , 0} | []]) do
    []
  end
  def rules([h | []]) do
    [h]
  end
  def rules([{move1, m} , {move2, n} | t]) do
    cond do
      move1 == move2 -> rules([{move1, m+n} | t])
      m == 0 -> rules([{move2, n} | t])
      true -> [{move1, m} | rules([{move2, n} | t])]
    end
  end

  def compress(list) do
    rl = rules(list)
    cond do
      rl == list -> list
      true -> compress(rl)
    end
  end
end
