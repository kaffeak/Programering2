defmodule Prim do
  def bench_to(n) do
    siev1(Enum.to_list(2..n))
    siev2(Enum.to_list(2..n))
    siev3(Enum.to_list(2..n))
  end

  #First solution
  def siev1([]) do [] end
  def siev1([h|t]) do [h|siev1(t -- Enum.filter(t, fn(x) -> rem(x, h) == 0 end))] end

  #Second solution
  def siev2(l) do siev2(l, []) end
  def siev2([h|t], []) do siev2(t, [h]) end
  def siev2([], prim) do prim end
  def siev2([h|t], prim) do siev2(t, div_siev2(h, prim)) end

  def div_siev2(e, p) do
    case p do
      [h|[]] -> cond do
        rem(e,h) != 0 -> [h,e]
        true -> [h]
      end
      [h|t] -> cond do
        rem(e,h) != 0 -> [h|div_siev2(e, t)]
        true -> [h|t]
      end
    end
  end

  #Third solution
  def siev3(l) do siev2(l, []) end
  def siev3([h|t], []) do siev2(t, [h]) end
  def siev3([], prim) do Enum.reverse(prim) end
  def siev3([h|t], prim) do siev2(t, div_siev2(h, prim)) end

  def div_siev3(e, p) do
    case p do
      [h|[]] -> cond do
        rem(e,h) != 0 -> [h,e]
        true -> [h]
      end
      [h|t] -> cond do
        rem(e,h) != 0 -> [h|div_siev2(e, t)]
        true -> [h|t]
      end
    end
  end
end
