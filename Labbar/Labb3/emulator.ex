defmodule Emulator do

  def test() do
    prgm =
  [{:addi, 1, 0, 5}, # $1 <- 5       1 = 5
  {:lw, 2, 0, 5}, # $2 <- data[5]    2 = 12
  {:add, 4, 2, 1}, # $4 <- $2 + $1   4 = 17
  {:addi, 5, 0, 1}, # $5 <- 1        5 = 1
  {:label, :loop},
  {:sub, 4, 4, 5}, # $4 <- $4 - $5   4 = 16
  {:out, 4}, # out $4
  {:bne, 4, 0, :loop}, # branch if not equal
  :halt]
    run(prgm)
  end

  def run(prgm) do
    code = Program.load(prgm, 0)
    reg = Register.new()
    out = Out.new()
    data = Data.write([],5,12)
    run(0, code, reg, data, out)
  end

  def run(pc, code, reg, data, out) do
    next = Program.read_instruction(code, pc)
    case next do
    :halt -> Out.close(out)
    {:out, ro} ->
      pc = pc + 4
      o = Register.read(reg, ro)
      out = Out.put(out, o)
      run(pc, code, reg, data, out)
    {:add, rd, rs, rt} ->
      pc = pc + 4
      s = Register.read(reg, rs)
      t = Register.read(reg, rt)
      reg = Register.write(reg, rd, s + t) # well, almost
      run(pc, code, reg, data, out)

    {:addi, rd, rt, imm} ->
      pc = pc + 4
      t = Register.read(reg, rt)
      reg = Register.write(reg, rd, t + imm)
      run(pc, code, reg, data, out)

    {:sub, rd, rs, rt} ->
      pc = pc + 4
      s = Register.read(reg, rs)
      t = Register.read(reg, rt)
      reg = Register.write(reg, rd, s - t)
      run(pc, code, reg, data, out)

    {:lw, rd, rt, imm} ->
      pc = pc + 4
      t = Register.read(reg, rt)
      d = Data.read(data, t + imm)
      reg = Register.write(reg, rd, d)
      run(pc, code, reg, data, out)

    {:sw, rs, rt, imm} ->
      pc = pc + 4
      t = Register.read(reg, rt)
      s = Register.read(reg, rs)
      data = Data.write(data, t + imm, s)
      run(pc, code, reg, data, out)

    {:beq, rs, rt, jump} ->
      t = Register.read(reg, rt)
      s = Register.read(reg, rs)
      cond do
        s == t -> pc = Program.get_jump(code, jump)
        true -> pc = pc + 4
      end
      run(pc, code, reg, data, out)

    {:bne, rs, rt, jump} ->
      t = Register.read(reg, rt)
      s = Register.read(reg, rs)
      pc = if t == s do pc + 4 else Program.get_jump(code, jump) end
      run(pc, code, reg, data, out)
    {:label, _} ->
      run(pc+4, code, reg, data, out)
    end
  end
end
