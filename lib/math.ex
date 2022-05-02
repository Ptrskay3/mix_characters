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
end
