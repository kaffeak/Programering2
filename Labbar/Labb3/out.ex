defmodule Out do

  def new() do
    []
  end

  def put([], input) do
    [input]
  end
  def put([head | []], input) do
    [head | [input]]
  end
  def put([head | tail], input) do
    [head | put(tail, input)]
  end

  def close(out) do
    :io.format("list: ")
    out
  end
end
