defmodule AvdentOfCode02Test do
  use ExUnit.Case

  @demo_entries [
    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
    "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
    "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
    "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
    "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
  ]

  test "first star answer" do
    entries = AvdentOfCode02.read_file()
    res = AvdentOfCode02.process_first_star(entries)
    IO.puts("02-first star answer : " <> Integer.to_string(res))
  end

  test "second star answer" do
    entries = AvdentOfCode02.read_file()
    res = AvdentOfCode02.process_second_star(entries)
    IO.puts("02-first star answer : " <> Integer.to_string(res))
  end

  test "demo first answer" do
    assert AvdentOfCode02.process_first_star(@demo_entries) == 8
  end

  test "find game id" do
    game_data = List.first(@demo_entries)
    assert AvdentOfCode02.get_game_id(game_data) == 1
  end

  test "get sets" do
    game_data = List.first(@demo_entries)
    assert AvdentOfCode02.get_sets(game_data) == [[{3, :blue}, {4, :red}], [{1, :red}, {2, :green}, {6, :blue}], [{2, :green}]]
  end
  

  test "demo second answer" do
    assert AvdentOfCode02.process_second_star(@demo_entries) == 2286
  end
end
