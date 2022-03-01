defmodule Move do

  def single({:one, n}, {listm, list1, list2}) do
    cond do
      n > 0 -> {Functions.take(listm, Enum.count(listm)-n), Functions.append(Functions.takelast(listm, n), list1), list2}
      n < 0 -> {Functions.append(listm, Functions.take(list1, -n)), Functions.drop(list1, -n), list2}
      true -> {listm, list1, list2}
    end
  end
  def single({:two, n}, {listm, list1, list2}) do
    cond do
      n > 0 -> {Functions.take(listm, Enum.count(listm)-n), list1, Functions.append(Functions.takelast(listm, n), list2)}
      n < 0 -> {Functions.append(listm, Functions.take(list2, -n)), list1, Functions.drop(list2, -n)}
      true -> {listm, list1, list2}
    end
  end

  def move([h | []], state) do
    [state ,single(h, state)]
  end
  def move([h | t], state) do
    [state | move(t, single(h, state))]
  end

end
