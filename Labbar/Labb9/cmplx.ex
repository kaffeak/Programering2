defmodule Cmplx do

  def new(r, i) do
    {r, i}
  end

  def add({ar, ai}, {br, bi}) do
    {ar + br, ai + bi}
  end

  def sqr({r, i}) do
    {r * r + -(i*i), r * i * 2}
  end

  def abs({r, i}) do
    :math.sqrt((r*r+i*i))
  end

end
