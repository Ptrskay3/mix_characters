defmodule Csv.File do
  @spec parse(String.t()) :: list
  def parse(content) do
    [_header | rows] = content |> String.split("\n", trim: true)

    rows
    |> Enum.map(&String.split(&1, ";", trim: true))
    |> Enum.map(&Csv.Row.parse(&1))
    |> Enum.filter(&(map_size(&1) != 0))
  end
end
