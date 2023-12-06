defmodule AvdentOfCodeXXTest do
  use ExUnit.Case

  @demo_entries []

  test "first star answer" do
    entries = AvdentOfCodeXX.read_file()
    res = AvdentOfCodeXX.process_first_star(entries)
    IO.puts("XX-first star answer : " <> Integer.to_string(res))
  end

  test "second star answer" do
    entries = AvdentOfCodeXX.read_file()
    res = AvdentOfCodeXX.process_second_star(entries)
    IO.puts("XX-second star answer : " <> Integer.to_string(res))
  end

  test "demo first answer" do
    assert AvdentOfCodeXX.process_first_star(@demo_entries) == 0
  end

  test "demo second answer" do
    assert AvdentOfCodeXX.process_second_star(@demo_entries) == 0
  end
end
