defmodule Csv do
  def get_file(file) do
    with {:ok, file} <- File.read(file) do
      file
    else
      err -> err
    end
  end

  def parse(content) do
    [_header | rows] = content |> String.split("\n")
    rows |> Enum.map(&String.split(&1, ";")) |> Enum.map(&Csv.Row.parse(&1))
  end
end
