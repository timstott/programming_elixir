# Data structures

## Tuples
{1, 2}
{status, count, action} = {:ok, 42, "next"}

## Lists
[1, 2 ,3] ++ [4, 5 ,6] # concatenation
[1, 2 ,3] -- [1]       # difference

## Maps
user = %{"name" => "Tim", "age" => 1}
key = "name"
user[key]
colors = %{red: 0xff000, green: 65280}
colors[:red]
colors.green
