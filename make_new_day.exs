Mix.install([:tesla])

defmodule AoCClient do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://adventofcode.com")

  plug(Tesla.Middleware.Headers, [
    {"user-agent", "tesla"},
    {"cookie",
     "session=53616c7465645f5fa031e86ff197ee2b0e53dff66d5658a0189140d543aab050870ca0de8ee612342bf2edca610d4acdb46876be5cc05b29e17ed756599211e4"}
  ])
end



defmodule AOC_Day_Prep_Script do
  use Tesla
  @lib_template_file "advent_of_code_XX.ex"
  @test_template_file "advent_of_code_XX_test.exs"
  @data_file "XX.csv"
  @lib_folder "Elixir/lib/"
  @test_folder "Elixir/test/"
  @template_folder "templates"

  def prepare_new_day() do
    day = get_new_day()
    IO.inspect(day)
    # create_new_day(day)
    fetch_day_input(day)
  end

  def get_new_day() do
    File.ls!()
    |> Enum.filter(fn f -> String.contains?(f, ".csv") end)
    |> Enum.sort()
    |> List.last()
    |> String.replace(".csv", "")
    |> Integer.parse()
    |> case do
      {current_day, _} -> current_day + 1
    end
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  def create_new_day(day) do
    lib_file =
      @lib_template_file
      |> String.replace("XX", day)

    test_file =
      @test_template_file
      |> String.replace("XX", day)

    data_file =
      @data_file
      |> String.replace("XX", day)

    lib_path = Path.join(@lib_folder, lib_file)
    lib_template_path = Path.join(@template_folder, @lib_template_file)
    test_path = Path.join(@test_folder, test_file)
    test_template_path = Path.join(@template_folder, @test_template_file)
    IO.inspect(test_path)
    IO.inspect(lib_path)
    IO.inspect(data_file)
    File.copy!(lib_template_path, lib_path)
    File.copy!(test_template_path, test_path)
    File.touch!(data_file)

    lib_content = File.read!(lib_template_path)

    lib_content =
      lib_content
      |> String.replace("XX", day)

    File.write!(lib_path, lib_content)
    test_content = File.read!(test_template_path)

    test_content =
      test_content
      |> String.replace("XX", day)

    File.write!(test_path, test_content)
  end

  def fetch_day_input(day) do
    {day_int, _} = Integer.parse(day)

    {:ok, %Tesla.Env{body: body}}=AoCClient.get("/2023/day/#{day_int}/input")

    File.write("#{day}.csv", body)
  end
end

AOC_Day_Prep_Script.prepare_new_day()
