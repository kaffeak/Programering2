defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn (w, h) -> Cmplx.new(x + k * (w - 1), y - k * (h-1)) end
    rows(width, height, trans, depth, [])
  end

  def rows(width, 0, trans, depth, image) do
    image ++ [row(width, 0, trans, depth, [])]
  end
  def rows(width, height, trans, depth, image) do
    row = row(width, height, trans, depth, [])
    rows(width, height-1, trans, depth, image ++ [row])
  end

  def row(0, height, trans, depth, before) do
    [Color.convert(Brot.mandelbrot(trans.(0, height), depth), depth) | before]
  end
  def row(width, height, trans, depth, before) do
    row(width-1, height, trans, depth, [Color.convert(Brot.mandelbrot(trans.(width, height), depth), depth) | before])
  end

end
