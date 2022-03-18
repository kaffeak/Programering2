defmodule Morse do

  def test() do
    '.- .-.. .-.. ..-- -.-- --- ..- .-. ..-- -... .- ... . ..-- .- .-. . ..-- -... . .-.. --- -. --. ..-- - --- ..-- ..- ... '
  end
  def test1() do
    '.... - - .--. ... ---... .----- .----- .-- .-- .-- .-.-.- -.-- --- ..- - ..- -... . .-.-.- -.-. --- -- .----- .-- .- - -.-. .... ..--.. ...- .----. -.. .--.-- ..... .---- .-- ....- .-- ----. .--.-- ..... --... --. .--.-- ..... ---.. -.-. .--.-- ..... .---- '
  end

  def table() do
    Enum.reduce(way(morse(), []), %{}, fn({char, code}, acc) -> Map.put(acc, char, code) end)
  end

  def way(:nil, _) do
    []
  end
  def way({:node, :na, right, left}, path) do
    way(right, [?- | path]) ++ way(left, [?. | path])
  end
  def way({:node, val, right, left}, path) do
    [{val, path}] ++ way(right, [?- | path]) ++ way(left, [?. | path])
  end

  def encode(input) do
    encode(input, table(), [])
  end
  def encode([], _, done) do
    reverse(done, [])
  end
  def encode([char | rest], table, part) do
    case part do
      [] -> encode(rest, table, lookup(char, table))
      _ -> encode(rest, table, lookup(char, table) ++ [32] ++ part)
    end
  end

  def lookup(char, map) do
    Map.get(map, char)
  end

  def decode(input) do
    decode(input, [], morse())
  end
  def decode([], done, _) do
    reverse(done, [])
  end
  def decode(code, sofar, tree) do
    {char, rest} = decode_char(code, tree)
    decode(rest, [char] ++ sofar, tree)
  end

  def decode_char([], {:node, char, _, _}) do
    {char, []}
  end
  def decode_char([?- | rest], {:node, _, path, _}) do
    decode_char(rest, path)
  end
  def decode_char([?. | rest], {:node, _, _, path}) do
    decode_char(rest, path)
  end
  def decode_char([?\s | rest], {:node, :na, _, _}) do
    {?*, rest}
  end
  def decode_char([?\s | rest], {:node, char, _, _}) do
    {char, rest}
  end

  def morse() do
    {:node, :na,
    {:node, 116,
    {:node, 109,
    {:node, 111,
    {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
    {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
    {:node, 103,
    {:node, 113, nil, nil},
    {:node, 122,
    {:node, :na, {:node, 44, nil, nil}, nil},
    {:node, 55, nil, nil}}}},
    {:node, 110,
    {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
    {:node, 100,
    {:node, 120, nil, nil},
    {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
    {:node, 101,
    {:node, 97,
    {:node, 119,
    {:node, 106,
    {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
    nil},
    {:node, 112,
    {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
    nil}},
    {:node, 114,
    {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
    {:node, 108, nil, nil}}},
    {:node, 105,
    {:node, 117,
    {:node, 32,
    {:node, 50, nil, nil},
    {:node, :na, nil, {:node, 63, nil, nil}}},
    {:node, 102, nil, nil}},
    {:node, 115,
    {:node, 118, {:node, 51, nil, nil}, nil},
    {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
    end

    def reverse([], l) do
      l
    end
    def reverse([h | t], l) do
      reverse(t, [h | l])
    end

end
