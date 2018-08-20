# Introduction

Ecto's core functionallity is contained in six modules

- Repo: proxy to the database
- Query
- Schema
- Changeset: update records based on data structure
- Migration
- Multi: coordinate transactions

# Repository

Inspired by the repository pattern. Is the single point of contact with the
database. The application creates queries which are submitted to the repository
which in turn submits it to the database.

Repository pattern is a great fit for languages that decouple data from
behaviour.

```elixir
# Create a Repo module to use Ecto
defmodule MusicDB.Repo do
  use Ecto.Repo, otp_app: :music_db
end
```

The `otp_app:` option tells Ecto where to find database connection options.

We can also add an `init` callback to the repository to override configuration
parameters (e.g. DATABASE_URL).

```elixir
# export DATABASE_URL="ecto://postgres:postgres@localhost/music_db"
def init(_, opts) do
{:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
end
```

## Low Level Functions

```elixir
# Insert artist with keyword list (can also use maps)
Repo.insert_all("artists", [[name: "Sonny Rollins"]])


# Use `set` option to specify which fields and values to change
Repo.update_all("artists", set: [updated_at: Ecto.DateTime.utc])

# Use `returning` option to specify which fields to return
Repo.insert_all(
  "artists",
  [
    %{name: "Max Roach"},
     %{name: "Art Blakey"}
  ],
  returning: [:id, :name]
)

# Raw SQL
Repo.query("select * from artists where id=1")
```

# Query

Create queries with the `from` (`Ecto.Query.from`) macro and use keyword list for the SQL.

## Basics

```elixir
# Convert query to raw SQL statement.
query = from "artists", select: [:name]
Repo.to_sql(:all, query)

# Dynamic parameters, note the pin operator ^ which indicates to the macro the
# expression needs to be evaluated
artist_name = "Bill Evans"
q = from "artists", where: [name: ^artist_name], select: [:id, :name]
```

## Query Bindings

To create more complex queries bind the column names to its table.

```elixir
# 🙅 Ecto doesn't know what to do with `name`
q = from "artists", where: name == "Bill Evans", select: [:id, :name]

# Instead bind `name` to the table with `in` (similar to aliases in SQL)
q = from a in "artists", where: a.name == "Bill Evans", select: [:id, :name]

# We can now also use expressions in `Ecto.Query.API`
q = from a in "artists", where: not is_nil(a.name), select: [:id, :name]
```

## Composing with raw SQL

Use `fragment` to expose specialized DBMS functions

```elixir
# Expose lower Postgres function
q = from a in "artists",
where: fragment("lower(?)", a.name) == "miles davis", select: [:id, :name]

# Extract fragment to macro for re-use
defmacro lower(arg) do
  quote do: fragment("lower(?)", unquote(arg))
end
```
