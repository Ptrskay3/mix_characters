## Original problem statement

The `static/characters.csv` file contains the list of characters appeared in the Star Wars universe.
“BBY” stands for Before the Battle of Yavin, it’s the “year zero” in the Galactic Standard Calendar.
For the age calculation let’s assume that it’s “year zero” and every character lives for the sake of simplicity.

Create an Elixir console app where it’s possible to ask for the following information:

1. The name of the heaviest character (if the mass is unknown, ignore that character)

2. - The average height of the male characters
   - The average height of the female characters

3. The age distribution of the characters by gender (where the gender can be “male”, “female” and “other”).
   The age groups are: “below 21”, “between 21 and 40", “above 40” and “unknown”. The result should be a Map(String, Map(String, Integer)).

## How to use

The API is available inside the `Csv.Server` module.

1.

```elixir
iex(1)> Csv.Server.heaviest(Csv.Server)
"The heaviest is Jabba Desilijic Tiure, with 1358.0!"
```

2.

```elixir
iex(2)> Csv.Server.average_height_by(Csv.Server, :male)
"The average height among males is 179.23728813559322!"
iex(3)> Csv.Server.average_height_by(Csv.Server, :female)
"The average height among females is 165.47058823529412!"
```

3.

```elixir
iex(4)> Csv.Server.distribution_by_age(Csv.Server)
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
```

Optionally you can switch out the file to `static/perf.csv` inside `mix.exs`'s application section for testing a significantly larger file.
