defmodule AvdentOfCode03Test do
  use ExUnit.Case

  @demo_entries []

  test "first star answer" do
    entries = AvdentOfCode03.read_file()
    res = AvdentOfCode03.process_first_star(entries)
    IO.puts("03-first star answer : " <> Integer.to_string(res))
  end

  test "second star answer" do
    entries = AvdentOfCode03.read_file()
    res = AvdentOfCode03.process_second_star(entries)
    IO.puts("03-first star answer : " <> Integer.to_string(res))
  end

  test "demo first answer" do
    assert AvdentOfCode03.process_first_star(@demo_entries) == 0
  end
  test "demo second answer" do
    assert AvdentOfCode03.process_second_star(@demo_entries) == 0
  end

end
