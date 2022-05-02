defmodule Csv do
  def get_file(file) do
    with {:ok, file} <- File.read(file) do
      file
    else
      err -> err
    end
  end

  def parse(content) do
    [_header | rows] = content |> String.split("\n", trim: true)

    rows
    |> Enum.map(&String.split(&1, ";", trim: true))
    |> Enum.map(&Csv.Row.parse(&1))
    |> Enum.filter(&(map_size(&1) != 0))
  end
end
