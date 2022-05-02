defmodule Csv.Query do
  def get_column(rows, column) do
    get_in(rows, [Access.all(), column])
  end

  def get_columns(rows, columns) do
    cols =
      for column <- columns do
        rows |> get_column(column)
      end

    Enum.zip(cols)
  end
end
