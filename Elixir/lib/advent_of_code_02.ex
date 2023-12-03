defmodule AvdentOfCode02 do
  @input "../02.csv"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def get_game_id(game_data) do
    game_data
    |> String.split(":")
    |> case do
      [head| _] -> head
    end
    |> String.split(" ")
    |> case do
      [_| tail] -> tail
    end
    |> List.last()
    |> String.to_integer()
  end

  def get_sets(line) do
    [_,data] = String.split(line,":")
    data 
    |> String.split(";")
    |> Enum.map(fn set ->
      String.split(set, ",")
      |> Enum.map(fn cubes ->
        String.trim(cubes)
        |> String.split(" ")
        |> case do
          [num, color] -> {String.to_integer(num), String.to_existing_atom(color)}
        end       
      end)
    end)
    
  end

  def process_first_star(entries) do
    entries
    |> Enum.reduce([], fn game, acc ->
      id = get_game_id(game)
      sets_result = get_sets(game)
      |> Enum.map(fn set ->
        is_valid_set(set)
      end)
      game_result = is_valid_game(sets_result)

      case game_result do
        true -> acc ++ [id]
        _ -> acc
      end
    end)
    |> Enum.sum()

  end

  def is_valid_game([head | tail]) do
    head and is_valid_game(tail)
  end
  def is_valid_game([]) do
    true
  end

  def is_valid_cube({num, :red}) when num <= 12, do: true
  def is_valid_cube({num, :green}) when num <= 13, do: true 
  def is_valid_cube({num, :blue}) when num <= 14, do: true
  def is_valid_cube(_), do: false

  def is_valid_set(set) do
    result = Enum.map(set, fn cubes ->
      is_valid_cube(cubes)
    end
    )

    case result do
      [true] -> true
      [true, true] -> true
      [true, true, true] -> true
      _ -> false
    end
    
  end

  def process_second_star(entries) do
    entries
    |> Enum.reduce([], fn game, acc ->
      res = game
      |> get_all_sets()
      |> Enum.reduce(%{red: 0, green: 0, blue: 0 }, fn {num, color}, acc ->
        if acc[color] < num do
          Map.put(acc, color, num)
        else
          acc
        end
      end)
      acc ++ [res[:blue] * res[:green] * res[:red]]
    end)
    |> Enum.sum()
  end
  def get_all_sets(line) do
    [_,data] = String.split(line,":")
    data 
    |> String.split([";", ","])
    |> Enum.map(fn e -> 
      e
      |> String.trim()
      |> String.split(" ")
      |> case do
        [num, color] -> {String.to_integer(num), String.to_existing_atom(color)}
      end       
    end)
  end
end
