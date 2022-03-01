defmodule Test do

  #------------------------------Part 2-------------------------------
	def double(n) do
		n + n
	end

	def fah_to_cel(a) do
		((a-32)/1.8)
	end

	def rect_area(a,b) do
		a * b
	end

	def square_area(a) do
		rect_area(a,a)
	end

	def circle_area(a) do
		a*a*3.14
	end
  #-------------------------End part 2-----------------------------


  #-------------------------Part 3-----------------------------------
  def product(m,n) do
    if m == 0 do
      0
    else
      n + product(m-1,n)
    end
  end

  def product_case(m,n) do
    case m do
      0 -> 0
      _ -> n + product_case(m-1,n)
    end
  end

  def product_cond(m,n) do
    cond do
      m == 0 -> 0
      true -> n + product_cond(m-1, n)
    end
  end

  def product_clauses(0, _) do
    0
  end
  def product_clauses(m,n) do
    product_clauses(m-1, n) + n
  end

  def exp(x,n) do
    case n do
      0 -> 1
      1 -> x
      _ -> case rem(n,2) do
        0 -> product_clauses(exp(x,div(n,2)), exp(x,div(n,2)))
        1 -> product_clauses(exp(x,(n-1)),x)
      end
      #_ -> product_clauses(x,exp(x,n-1))
    end
  end
  #------------------------End part 3--------------------------------

  #--------------------------Part 4.1----------------------------------
  def nth(n, l) do
    [head | tail] = l
    case n do
      0 -> head
      _ -> nth(n-1, tail)
    end
  end

  def len(l) do
    [_ | t] = l
    case t do
      [] -> 1
      _ -> len(t) + 1
    end
  end

  def sum(l) do
    [h | t] = l
    case t do
      [] -> h
      _ -> h + sum(t)
    end
  end

  def duplicate(l) do
    [h | t] = l
    case t do
      [] -> [h , h]
      _ -> [h | [h |duplicate(t)]]
    end
  end

  def add(x, l) do
    [h | t] = l
    cond  do
      h == x -> [h | t]
      t == [] -> [h | [x]]
      true -> [h | add(x, t)]
    end
  end

  def remove(x, l) do
    [h | t] = l
    cond do
      h == x && t == []-> t
      h == x -> remove(x, t)
      t == [] -> [h]
      true -> [h | remove(x, t)]
    end
  end

  def unique(l) do
    [h | t] = l
    cond do
      t == [] -> [h]
      true -> add(h, unique(t))
    end
  end

  def pack([]) do
    []
  end
  def pack(l) do
    [h | t] = l
    [[h | pack(h , t)] | pack(remove(h , t))]
  end

  def pack(_ , []) do
    []
  end
  def pack(h , [h | t]) do
    [h | pack(h, t)]
  end
  def pack(h, [_ | t]) do
    pack(h, t)
  end

  def reverse(l) do
    reverse(l, [])
  end
  def reverse([], l) do
    l
  end
  def reverse([h | t], l) do
    reverse(t, [h | l])
  end

  #------------------Part 4.3----------------------
  def insert(e, l) do
    case l do
      [] -> [e]
      [h | t]->
      cond do
        h > e -> [e | l]
        t == [] -> [h | [e]]
        true -> [h | insert(e, t)]
      end
    end
  end

  def isort(l) do
    cond do
      l == [] -> []
      true -> isort(l , [])
    end
  end
  def isort([h | t], sorted) do
    case t do
      [] -> [h]
      _ -> insert(h , isort(t, sorted))
    end
  end

end
