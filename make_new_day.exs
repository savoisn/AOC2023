defmodule AOC_Day_Prep_Script do
  @lib_template_file "advent_of_code_XX.ex"
  @test_template_file "advent_of_code_XX_test.exs"
  @data_file "XX.csv"
  @lib_folder "Elixir/lib/"
  @test_folder "Elixir/test/"
  @template_folder "templates"

  def prepare_new_day() do
    day = get_new_day()
    create_new_day(day)
  end

  def get_new_day() do
    ls = File.ls!()
         |> Enum.filter(fn f -> String.contains?(f, ".csv") end)
         |> Enum.sort()
    newest_file_name=List.last(ls)
    current_day_name = String.replace(newest_file_name,".csv","")
    {current_day, _} = Integer.parse(current_day_name)
    new_day = current_day + 1
    new_day_name = Integer.to_string(new_day)
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
end

AOC_Day_Prep_Script.prepare_new_day()
