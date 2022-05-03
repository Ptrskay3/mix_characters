defmodule Csv.Math do
  @type state :: [Csv.Row.row()]

  @spec heaviest(state) :: {String.t(), float()}
  def heaviest(state) do
    Csv.Query.get_columns(state, [:name, :mass])
    |> Stream.filter(fn {_, mass} -> !is_nil(mass) end)
    |> Stream.map(fn {name, mass} -> {name, to_number(mass)} end)
    |> Stream.reject(fn {_, mass} -> !mass end)
    |> Enum.max_by(fn {_, mass} -> mass end)
  end

  @spec average_height_by_gender(state, String.t()) :: float()
  def average_height_by_gender(state, target_gender) do
    valid_rows =
      Csv.Query.get_columns(state, [:gender, :height])
      |> Stream.filter(fn {gender, _} -> gender == target_gender end)
      |> Stream.filter(fn {_, height} -> !is_nil(height) end)
      |> Stream.map(fn {_, height} -> to_number(height) end)
      |> Stream.reject(fn height -> !height end)

    count = valid_rows |> Enum.count()
    sum = valid_rows |> Enum.sum()

    sum / count
  end

  @spec distribution_by_age(state) :: map()
  def distribution_by_age(state) do
    groups =
      Csv.Query.get_columns(state, [:gender, :birth_year])
      |> Enum.group_by(fn {gender, _} -> partition_by_gender(gender) end)

    for {category, rows} <- groups do
      statistics =
        rows
        |> List.flatten()
        |> Enum.map(fn {_, age} ->
          case String.ends_with?(age, "BBY") do
            true -> String.trim_trailing(age, "BBY") |> to_number
            false -> age
          end
        end)
        |> Enum.frequencies_by(&partition_by_age(&1))

      %{category => statistics}
    end
    |> flatten_into_map
  end

  # Utility functions. They might have a common module, but it's fine for now..

  # I'd rather use atoms instead of these magic strings, but let's stick to the description.
  defp partition_by_gender(gender) do
    case gender do
      "female" -> "female"
      "male" -> "male"
      _ -> "other"
    end
  end

  defp partition_by_age(age) when is_number(age) do
    case age do
      x when 0 < x and x < 21 -> "below 21"
      x when x >= 21 and x < 40 -> "between 21 and 40"
      x when x >= 40 -> "above 40"
      _ -> "unknown"
    end
  end

  defp partition_by_age(_age) do
    "unknown"
  end

  defp to_number(item) do
    case Float.parse(item) do
      {num, ""} -> num
      _ -> false
    end
  end

  defp flatten_into_map(list) when is_list(list) do
    Enum.reduce(list, fn x, y -> Map.merge(x, y, fn _, v1, v2 -> v1 ++ v2 end) end)
  end
end
