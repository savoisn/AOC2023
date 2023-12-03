defmodule AvdentOfCode03 do
  @input "../03.csv"

  def read_file do
    File.stream!(@input)
  end

  def process_first_star(_entry) do
    0
  end

  def process_second_star(_entry) do
    0
  end
end
