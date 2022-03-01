defmodule Data do

  def read([], _) do
    nil
  end
  def read([[{_, adress},{_, val}] | _], adress) do
    val
  end
  def read([_ | tail], adress) do
    read(tail, adress)
  end

  def write([], adress, val) do
    [[{:label, adress}, {:word, val}]]
  end
  def write([head | []], adress, val) do
    [head | [[{:label, adress},{:word, val}]]]
  end
  def write([[{_, adress},_] | tail], adress, val) do
    [[{:label, adress}, {:word, val}] | tail]
  end
  def write([head | tail], adress, val) do
    [head | write(tail, adress, val)]
  end
end
