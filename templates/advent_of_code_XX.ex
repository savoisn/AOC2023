defmodule AvdentOfCodeXX do
  @input "../XX.csv"

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
