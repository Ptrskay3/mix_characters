## CSV

The `static/characters.csv` file contains the list of characters appeared in the Star Wars universe.
“BBY” stands for Before the Battle of Yavin, it’s the “year zero” in the Galactic Standard Calendar. 
For the age calculation let’s assume that it’s “year zero” and every character lives for the sake of simplicity.


Create an Elixir console app where it’s possible to ask for the following information:

The name of the heaviest character (if the mass is unknown, ignore that character)
The average height of the male characters
The average height of the female characters
:muscle: The age distribution of the characters by gender (where the gender can be “male”, “female” and “other”)
The age groups are: “below 21”, “between 21 and 40", “above 40” and “unknown”
The result should be a Map(String, Map(String, Integer))
