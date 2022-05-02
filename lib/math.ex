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

  def age_distribution(state) do
    groups =
      Csv.Query.get_columns(state, [:gender, :birth_year])
      |> Enum.group_by(fn {gender, _} -> partition_by_gender(gender) end)

    for {category, rows} <- groups do
      filtered =
        rows
        |> List.flatten()
        |> Enum.map(fn {gender, age} ->
          case String.ends_with?(age, "BBY") do
            true -> {gender, String.trim_trailing(age, "BBY") |> to_number}
            false -> {gender, age}
          end
        end)
        |> Enum.group_by(fn {_, age} -> partition_by_age(age) end)
        |> Enum.map(fn {group, elems} -> %{group => elems |> length} end)
        |> flatten_into_map

      %{category => filtered}
    end
    |> flatten_into_map
  end

  defp partition_by_gender(gender) do
    case gender do
      "female" -> "female"
      "male" -> "male"
      _ -> "other"
    end
  end

  defp partition_by_age(age) when is_number(age) do
    case age do
      x when 0 < x and x < 21 -> :young
      x when x >= 21 and x < 40 -> :middle
      x when x >= 40 -> :old
      _ -> :unknown
    end
  end

  defp partition_by_age(_age) do
    :unknown
  end

  defp flatten_into_map(list) when is_list(list) do
    Enum.reduce(list, fn x, y -> Map.merge(x, y, fn _, v1, v2 -> v1 ++ v2 end) end)
  end
end
