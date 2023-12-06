defmodule AvdentOfCode03 do
  @input "../03.csv"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)

    # |> Enum.slice(57, 3)
  end

  def process_first_star(entry) do
    # map = map_entry(entry)

    # numbers = get_numbers(entry)
    # IO.inspect({"numbers", Enum.sort(numbers)})
    numbers = get_numbers2(entry)
    # IO.inspect({"numbers2", Enum.sort(numbers2)})

    symbols = get_symbols2(entry)
    IO.inspect({"symbols2", Enum.sort(symbols)})

    # IO.inspect(Enum.sort(symbols) == Enum.sort(symbols2))

    symbols =
      Enum.reduce(symbols, %{}, fn {x, y, v}, acc ->
        Map.put(acc, {x, y}, v)
      end)

    filter_number_with_symbols_around(numbers, symbols)
    |> Enum.sort_by(fn {_, y, _} -> y end)
    |> IO.inspect()
    |> Enum.reduce(0, fn {_, _, val}, acc ->
      acc + String.to_integer(val)
    end)
  end

  def filter_number_with_symbols_around(numbers, symbols) do
    Enum.filter(numbers, fn {x, y, value} ->
      Enum.reduce(get_coordonnates(x, y, value), false, fn e, acc ->
        if Map.has_key?(symbols, e) do
          acc or true
        else
          acc or false
        end
      end)
    end)
  end

  def get_coordonnates(x, y, value) do
    len = String.length(value)

    up_and_under =
      for v <- (x - 1)..(x + len) do
        [{v, y - 1}, {v, y + 1}]
      end
      |> List.flatten()

    ret = up_and_under ++ [{x - 1, y}, {x + len, y}]

    if value == "272" do
      IO.inspect({x, y, value})
      IO.inspect(ret)
    end

    ret
  end

  def get_numbers2(entry) do
    {_, numbers} =
      Enum.reduce(entry, {0, []}, fn line, {y, acc} ->
        reg = ~r/[0-9]{1,3}/

        acc =
          Regex.scan(reg, line, return: :index)
          |> List.flatten()
          |> Enum.map(fn {start, length} ->
            {start, y, binary_part(line, start, length)}
          end)
          |> Kernel.++(acc)

        {y + 1, acc}
      end)

    numbers
  end

  def get_symbols2(entry) do
    {_, numbers} =
      Enum.reduce(entry, {0, []}, fn line, {y, acc} ->
        reg = ~r/[^.|^0-9]{1}/

        acc =
          Regex.scan(reg, line, return: :index)
          |> List.flatten()
          |> Enum.map(fn {start, length} ->
            {start, y, binary_part(line, start, length)}
          end)
          |> Kernel.++(acc)

        {y + 1, acc}
      end)

    numbers
  end

  def get_numbers(entry) do
    {_, _, numbers} =
      Enum.reduce(entry, {0, 0, []}, fn line, {x, y, acc} ->
        items = list_items_of_line(line)

        numbers =
          for item <- items do
            get_items_position(item, line, y)
          end

        numbers = List.flatten(numbers)
        {x, y + 1, acc ++ numbers}
      end)

    numbers
  end

  def get_symbols(entry) do
    {_, _, symbols} =
      Enum.reduce(entry, {0, 0, []}, fn line, {x, y, acc} ->
        items = list_symbol_of_line(line)

        numbers =
          for item <- items do
            get_items_position(item, line, y)
          end

        numbers = List.flatten(numbers)
        {x, y + 1, acc ++ numbers}
      end)

    symbols
  end

  def get_items_position(item, line, line_number) do
    poses = :binary.matches(line, item)

    positions =
      for {pos, _} <- poses do
        {pos, line_number, item}
      end

    List.flatten(positions)
  end

  def list_symbol_of_line(line) do
    items = String.split(line, ".", trim: true)

    items =
      for item <- items do
        String.replace(item, ~r/\d/, "")
      end

    items = List.flatten(items)
    Enum.filter(items, fn x -> x != "" end)
  end

  def list_items_of_line(line) do
    items = String.split(line, ".", trim: true)

    items =
      for item <- items do
        String.replace(item, ~r/[^\d]/, "")
      end

    items = List.flatten(items)
    Enum.filter(items, fn x -> x != "" end)
  end

  def map_entry(entry) do
    {_, _, map} =
      Enum.reduce(entry, {0, 0, %{}}, fn e, {x, y, schema} ->
        {_, lines} = get_line_schema(String.graphemes(e))

        {_, schema} =
          Enum.reduce(lines, {0, schema}, fn line, {x2, acc} ->
            {x2 + 1, Map.put(acc, {x2, y}, elem(line, 1))}
          end)

        {x, y + 1, schema}
      end)

    map
  end

  def get_line_schema(line) do
    Enum.reduce(line, {0, %{}}, fn e, {x, schema} ->
      schema = Map.put(schema, x, e)
      {x + 1, schema}
    end)
  end

  def process_second_star(entry) do
    # numbers = get_numbers(entry)
    # IO.inspect({"numbers", Enum.sort(numbers)})
    numbers = get_numbers2(entry)
    # IO.inspect({"numbers2", Enum.sort(numbers2)})

    symbols = get_symbols2(entry)

    potential_gears =
      Enum.filter(symbols, fn {_, _, s} ->
        s == "*"
      end)

    potential_gears = symbols

    # IO.inspect(Enum.sort(symbols) == Enum.sort(symbols2))

    symbols =
      Enum.reduce(symbols, %{}, fn {x, y, v}, acc ->
        Map.put(acc, {x, y}, v)
      end)

    numbers = complete_numbers(numbers)

    numbers =
      Enum.reduce(numbers, %{}, fn {x, y, v}, acc ->
        Map.put(acc, {x, y}, v)
      end)

    gears =
      find_gears(potential_gears, numbers)
      |> Enum.map(fn {x, y, _, arr} ->
        if length(arr) > 4 do
          IO.inspect(arr)
        end
        {x, y, Enum.uniq(arr)}
      end)
      |> Enum.filter(fn {_, _, e} ->
        length(e) > 1
      end)
      |> Enum.reduce(0, fn {_, _, val}, acc ->
        acc + Enum.reduce(val, 1, fn v, a -> a * v end)
      end)
  end

  def complete_numbers(numbers) do
    numbers ++
      Enum.reduce(numbers, [], fn {x, y, e}, acc ->
        completed_acc =
          Enum.reduce(1..(String.length(e) - 1), [], fn b, acc ->
            acc ++ [{x + b, y, e}]
          end)

        acc ++ completed_acc
      end)
  end

  def find_gears(symbols, numbers) do
    Enum.map(symbols, fn {x, y, value} ->
      Enum.reduce(get_coordonnates(x, y, value), {x, y, value, []}, fn e, {x, y, value, acc} ->
        gears =
          if Map.has_key?(numbers, e) do
            acc ++ [String.to_integer(numbers[e])]
          else
            acc
          end

        {x, y, value, gears}
      end)
    end)
  end
end
