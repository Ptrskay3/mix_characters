defmodule CsvTest do
  use ExUnit.Case
  doctest Csv

  test "Jabba is the heaviest" do
    assert GenServer.call(Csv.Server, :heaviest) ==
             "The heaviest is Jabba Desilijic Tiure, with 1358.0!"
  end

  test "Average heights are right" do
    # These tests are not very good because of the string return values..
    assert GenServer.call(Csv.Server, {:avg_height, :female}) ==
             "The average height among females is 165.47058823529412!"

    assert GenServer.call(Csv.Server, {:avg_height, :male}) ==
             "The average height among males is 179.23728813559322!"
  end

  test "Distribution is computed correctly" do
    assert GenServer.call(Csv.Server, :age_distribution) ==
             %{
               "female" => %{"above 40" => 7, "below 21" => 1, "unknown" => 11},
               "male" => %{
                 "above 40" => 22,
                 "below 21" => 2,
                 "between 21 and 40" => 7,
                 "unknown" => 31
               },
               "other" => %{
                 "above 40" => 2,
                 "below 21" => 1,
                 "between 21 and 40" => 1,
                 "unknown" => 2
               }
             }
  end
end
