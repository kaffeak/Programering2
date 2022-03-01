defmodule Prime do
  def bench() do
    ls = [1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, 512000]
    #ls = [100 , 1000, 10000, 100000]
    bench(ls)
  end
  def bench([h | t]) do
    IO.write("  #{prime1(h)}\t\t\t\t#{prime2(h)}\t\t\t\t#{prime3(h)}\n")
    case t do
      [] -> :ok
      _ -> bench(t)
    end
  end

  def prime1(n) do
    lists = Enum.to_list(2..n)
    {uSecs, :ok} = :timer.tc( fn  -> find_prime1(lists)
                              :ok end)
    uSecs
  end
  def prime2(n) do
    lists = Enum.to_list(2..n)
    {uSecs, :ok} = :timer.tc( fn  -> find_prime2(lists)
                              :ok end)
    uSecs
  end
  def prime3(n) do
    lists = Enum.to_list(2..n)
    {uSecs, :ok} = :timer.tc( fn  -> find_prime3(lists)
                              :ok end)
    uSecs
  end
  def find_prime1([]) do  end
  def find_prime1([h | t]) do
    temp_list = div_prime1(h, t)
    case temp_list do
      nil -> [h]
      _ ->  [h | find_prime1(temp_list)]
    end
  end
  def div_prime1(_, []) do  end
  def div_prime1(prime, [h | t]) do
    cond do
      rem(h, prime) != 0 -> case t do
        [] -> [h]
        _ -> [h | div_prime1(prime, t)]
      end
      true -> case t do
        [] -> []
        _ ->  div_prime1(prime, t)
      end
    end
  end
  def find_prime2(list) do
    find_prime2(list, [])
  end
  def find_prime2([], primes) do
    primes
  end
  def find_prime2([h | t], []) do
    find_prime2(t, [h])
  end
  def find_prime2([h | t], primes) do
    find_prime2(t, div_prime2(h, primes))
  end
  def div_prime2(e, [h | []]) do
    cond do
      rem(e, h) != 0 -> [h, e]
      true -> [h]
    end
  end
  def div_prime2(e, [h | t]) do
      cond do
        rem(e, h) != 0 -> [h | div_prime2(e, t)]
        true -> [h | t]
      end
  end

  def find_prime3(list) do
      reverse(find_prime3(list, []), [])
  end
  def find_prime3([], primes) do
    primes
  end
  def find_prime3([h | t], []) do
    find_prime3(t, [h])
  end
  def find_prime3([h | t], primes) do
    find_prime3(t, div_prime3(h, primes, primes))
  end
  def div_prime3(e, [h | []], primes) do
    cond do
      rem(e, h) != 0 -> [e | primes]
      true -> primes
    end
  end
  def div_prime3(e, [h | t], primes) do
    cond do
      rem(e, h) != 0 -> div_prime3(e, t, primes)
      true -> primes
    end
  end
  def reverse([], l) do
    l
  end
  def reverse([h | t], l) do
    reverse(t, [h | l])
  end
end
