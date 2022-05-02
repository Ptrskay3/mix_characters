defmodule Csv.Math do
  defp to_number(item) do
    case Float.parse(item) do
      {num, ""} -> num
      _ -> false
    end
  end

  def heaviest(state) do
    Csv.Query.get_columns(state, [:name, :mass])
    |> Stream.filter(fn {_, mass} -> !is_nil(mass) end)
    |> Stream.map(fn {name, mass} -> {name, to_number(mass)} end)
    |> Stream.reject(fn {_, mass} -> !mass end)
    |> Enum.max_by(fn {_, mass} -> mass end)
  end

  def average_height_by_gender(state, target) do
    valid_rows =
      Csv.Query.get_columns(state, [:gender, :height])
      |> Stream.filter(fn {gender, _} -> gender == target end)
      |> Stream.filter(fn {_, height} -> !is_nil(height) end)
      |> Stream.map(fn {_, height} -> to_number(height) end)
      |> Stream.reject(fn height -> !height end)

    count = valid_rows |> Enum.count()
    sum = valid_rows |> Enum.sum()

    sum / count
  end
end
