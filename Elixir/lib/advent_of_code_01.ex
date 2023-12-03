defmodule AvdentOfCode01 do
  @input "../01.csv"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_first_star(entry) do
    first =
      entry
      |> Enum.map(fn line -> get_first_digit(line) end)

    last =
      entry
      |> Enum.map(fn line -> get_first_digit(String.reverse(line)) end)

    Enum.zip(first, last)
    |> Enum.reduce(0, fn {a, b}, acc ->
      acc + (a * 10 + b)
    end)
  end

  def get_first_digit(line) do
    r = String.graphemes(line)
    Enum.reduce_while(r, 0, fn g, _ -> is_only_num(g) end)
  end

  def is_only_num(string) do
      case Integer.parse(string) do
        :error -> {:cont, 0}
        i -> {:halt, elem(i, 0)}
      end
  end

  def process_second_star(entry) do
    dict = %{
      "one" => 1,
      "two" => 2,
      "three" => 3,
      "four" => 4,
      "five" => 5,
      "six" => 6,
      "seven" => 7,
      "eight" => 8,
      "nine" => 9,
      "1" => 1,
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9
    }

    items = Map.keys(dict)

    Enum.reduce(entry, 0, fn e, acc ->
      arr =
        Enum.reduce(items, [], fn item, acc2 ->
          el = :binary.matches(e, item)
               |> Enum.map(fn t -> {elem(t, 0), item} end)
          acc2 ++ el
        end)

      sorted = arr |> Enum.sort_by(&elem(&1, 0))
      first = List.first(sorted)
      last = List.last(sorted)
      add = dict[elem(first, 1)] * 10 + dict[elem(last, 1)]
      acc + add
    end)
  end
end
