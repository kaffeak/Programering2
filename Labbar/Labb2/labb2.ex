defmodule Derivate do

  @type literal() :: {:num, number()}
                  |  {:var, atom()}

  @type expr() :: {:add , expr(), expr()}
               |  {:mul , expr(), expr()}
               |  {:exp , expr(), expr()}
               |  {:ln  , expr()}
               |  {:sin , expr()}
               |  literal()


  def deriv({:num, _}, _) do
    {:num , 0}
  end
  def deriv({:var, v}, v) do
    {:num, 1}
  end
  def deriv({:var, _}, _) do
    {:num, 0}
  end
  def deriv({:mul, e1, e2}, v) do
    case e1 do
      {:num, n1} -> {:mul, {:num, n1}, deriv(e2, v)}
      _ -> case e2 do
        {:num, n1} -> {:mul, {:num, n1}, deriv(e1, v)}
        _ -> {:mul , deriv(e1, v), deriv(e2, v)}
      end
    end
  end
  def deriv({:add, e1, e2}, v) do
    {:add ,deriv(e1 , v) , deriv(e2 , v)}
  end
  def deriv({:exp, {:var, v}, {:num , n}}, v) do
    cond do
      n == 0 -> {:mul , 0, 0}
      true -> {:mul, {:num , n}, {:exp ,{:var, v},{:num ,n-1}}}
    end
  end
  def deriv({:ln , e1}, v) do
    case e1 do
      {:var , v} -> {:exp , {:var , v} , {:num , -1}}
      _ -> {:mul , deriv(e1, v) , {:exp , e1 , -1}}
    end
  end
  def deriv({:sin , e1}, v) do
    case e1 do
      {:var , v} -> {:cos , {:var, v}}
      _ -> {:mul , deriv(e1 , v) , {:cos ,  e1}}
    end
  end

  def simp(func, var) do
    simp(deriv(func, var))
  end
  def simp(arg) do
    case arg do
      {:num , n} -> n
      {:var , v} -> v
      {:mul , e1, e2} -> case e1 do
        {:num , n1} -> case e2 do
          {:num , n2} -> cond do
            (n1 || n2) == 0 -> ""
            true -> "#{n1*n2}"
          end
          {:var , v1} -> case n1 do
            0 -> ""
            _ -> "#{n1}#{v1}"
          end
          _ -> case n1 do
            0 -> ""
            _ -> "#{n1}(#{simp(e2)})"
          end
        end
        {:var , v1} -> case e2 do
          {:num , n1} -> case n1 do
            0 -> ""
            _ -> "#{n1}#{v1}"
          end
          {:var , v2} -> "#{v1}#{v2}"
          _ -> "#{v1}(#{simp(e2)})"
        end
        _ -> case e2 do
          {:num , n1} -> case n1 do
            0 -> ""
            _ -> "#{n1}(#{simp(e1)})"
          end
          {:var , v1} -> "#{v1}(#{simp(e1)})"
          _ -> "(#{simp(e1)})(#{simp(e2)})"
        end
      end
      {:add , e1, e2} -> "#{simp(e1)} + #{simp(e2)}"
      {:exp , e1, n} -> case n do
        {:num, 0} -> ""
        {:num, 1} -> case e1 do
          {:var, v1} -> "#{v1}"
          _ -> "#{simp(e1)}"
        end
        {:num, n1} -> case e1 do
          {:var, v1} -> "#{v1}^#{n1}"
          _ -> "(#{simp(e1)})^#{n1}"
        end
      end
      {:cos , e1} ->  "(sin(#{simp(e1)}))"
    end
  end
end
