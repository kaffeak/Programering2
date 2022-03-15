defmodule Demo do

  def demo() do
    small(-0.9, -0.05, -0.6)
  end

  def small(x0, y0, xn) do
    width = 1080
    height = 1080
    depth = 255
    k = (xn - x0)/width
    image = Mandel.mandelbrot(width-1, height-1, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end

end
