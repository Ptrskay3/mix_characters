defmodule Csv.Query do
  def get_column(rows, column) do
    get_in(rows, [Access.all(), column])
  end
end
