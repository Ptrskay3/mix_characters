defmodule Csv.Row do
  @type row :: %{
          name: String.t(),
          height: String.t(),
          mass: String.t(),
          hair_color: String.t(),
          skin_color: String.t(),
          eye_color: String.t(),
          birth_year: String.t(),
          gender: String.t(),
          homeworld: String.t(),
          species: String.t()
        }

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

  @spec parse([String.t()]) :: row
  def parse(row) do
    @fields |> Enum.zip(row) |> Enum.into(%{})
  end
end
