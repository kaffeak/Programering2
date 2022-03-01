defmodule Program do

  def load([head | []], pc) do
    [{pc, head}]
  end
  def load([head | tail], pc) do
    [{pc, head} | load(tail, pc + 4)]
  end

  def read_instruction([],_) do
    nil
  end
  def read_instruction([{pc, instruction} | _], pc) do
    instruction
  end
  def read_instruction([_ | tail], pc) do
    read_instruction(tail, pc)
  end

  def get_jump([{pc,_} | []], _) do
    pc
  end
  def get_jump([{pc, {:label, jump}} | _], jump) do
    pc
  end
  def get_jump([_ | tail], jump) do
    get_jump(tail, jump)
  end
end
