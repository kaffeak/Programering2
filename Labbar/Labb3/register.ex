defmodule Register do
#
  #def new() do
  #  {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
  #end
#
  #def read(_, 0) do
  #  0
  #end
  #def read(reg, index)  do
  #  elem(reg, index)
  #end
#
  #def write(reg, index, val) do
  #  put_elem(reg, index, val)
  #end
#
  def new() do
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  end
  def read([head | _], 0) do
    head
  end
  def read([_ | tail], index) do
    read(tail, index - 1)
  end
  def write([_ | tail], 0, val) do
    [val | tail]
  end
  def write([head | tail], index, val) do
    [head | write(tail, index-1, val)]
  end
end
