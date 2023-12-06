defmodule AvdentOfCode03Test do
  use ExUnit.Case

  @demo_entries [
    "467..114..",
    "...*......",
    "..35..633.",
    "......#...",
    "617*......",
    ".....+.58.",
    "..592.....",
    "......755.",
    "...$.*....",
    ".664.598.."
  ]

  @tag :skip
  test "first star answer" do
    entries = AvdentOfCode03.read_file()
    res = AvdentOfCode03.process_first_star(entries)
    IO.puts("03-first star answer : " <> Integer.to_string(res))
  end

  test "second star answer" do
    entries = AvdentOfCode03.read_file()
    res = AvdentOfCode03.process_second_star(entries)
    IO.puts("03-second star answer : " <> Integer.to_string(res))
  end

  test "demo first answer" do
    assert AvdentOfCode03.process_first_star(@demo_entries) == 4361
  end

  @tag :skip
  test "demo second answer" do
    assert AvdentOfCode03.process_second_star(@demo_entries) == 467_835
  end
end
