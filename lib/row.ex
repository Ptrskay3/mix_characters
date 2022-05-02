defmodule Csv.Row do
  @fields [
    :name,
    :height,
    :mass,
    :hair_color,
    :skin_color,
    :eye_color,
    :birth_year,
    :gender,
    :homeworld,
    :species
  ]

  def parse(row) do
    @fields |> Enum.zip(row) |> Enum.into(%{})
  end
end
