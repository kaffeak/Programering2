defmodule Brot do

  def mandelbrot(c, n) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, n)
  end

  def test(i, _, _, i) do
    0
  end
  def test(i, position, c, n) do
    zn = Cmplx.add(Cmplx.sqr(position), c)
    cond  do
      Cmplx.abs(zn) > 2 -> i
     true -> test(i+1, zn, c, n)
    end
  end

end
