
defmodule AvdentOfCode01Test do
  use ExUnit.Case

  @demo_entries [
    "1abc2",
    "pqr3stu8vwx",
    "a1b2c3d4e5f",
    "treb7uchet"
  ]

  @part2_demo_entries [
    "two1nine",
    "eightwothree",
    "abcone2threexyz",
    "xtwone3four",
    "4nineeightseven2",
    "zoneight234",
    "7pqrstsixteen",
  ]

  test "first star answer" do
    entries = AvdentOfCode01.read_file()
    res = AvdentOfCode01.process_first_star(entries)
    IO.puts("01-first star answer : " <> Integer.to_string(res))
  end

  test "second star answer" do
    entries = AvdentOfCode01.read_file()
    res = AvdentOfCode01.process_second_star(entries)
    IO.puts("01-second star answer : " <> Integer.to_string(res))
  end

  test "demo first answer" do
    assert AvdentOfCode01.process_first_star(@demo_entries) == 142
  end

  test "demo second answer" do
    assert AvdentOfCode01.process_second_star(@part2_demo_entries) == 281
  end
end
