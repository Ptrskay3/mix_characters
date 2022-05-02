defmodule Csv.Math do
  defp to_number(item) do
    case Float.parse(item) do
      {num, ""} -> num
      _ -> false
    end
  end

  def heaviest(state) do
    state
    |> Csv.Query.get_column(:mass)
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.map(&to_number(&1))
    |> Enum.reject(&(!&1))
    |> Enum.max()
  end
end
