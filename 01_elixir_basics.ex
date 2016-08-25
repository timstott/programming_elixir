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

# Scope

## with
content = "Hello World"
result = with content = "Goodbye",
              name = "Tim",
           IO.puts [content, name]
         do 
           "The world is mine"
         end
IO.puts result
IO.puts content

# Functions
sum = fn (a, b) -> a + b end
sum.(1, 2)

## Exercises
list_concat = fn (l1, l2) -> l1 ++ l2 end
list_concat.([:a, :b], [:c, :d])

pair_tuple_to_list = fn ({a, b}) -> [a, b] end
pair_tuple_to_list.({1234, 5678})

handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error}  -> "Error: #{:file.format_error(error)}" # :file is erlang file module
end
handle_open.(File.open("/etc/hosts"))
handle_open.(File.open("/etc/hostx"))

fizzbuzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, x) -> x
end

IO.puts fizzbuzz.(0, 0, 1)
IO.puts fizzbuzz.(0, 1, 1)
IO.puts fizzbuzz.(1, 0, 1)
IO.puts fizzbuzz.(1, 1, 1)

conditional_less_fizzbuzz = fn(n) ->
  fizzbuzz.(rem(n, 3), rem(n, 5), n)
end

IO.puts conditional_less_fizzbuzz.(10)
IO.puts conditional_less_fizzbuzz.(11)
IO.puts conditional_less_fizzbuzz.(12)
IO.puts conditional_less_fizzbuzz.(15)


## Function closure
greeter = fn name ->
  fn ->
    "Hello #{name}!"
  end
end

dave_greeter = greeter.("Dave")
IO.puts dave_greeter.()

add_b = fn a ->
  fn b ->
    a + b
  end
end

add_two = add_b.(2)
IO.puts add_two.(8)

## Exercises
prefix = fn x ->
  fn y ->
    "#{x} #{y}"
  end
end
prefix.("Mr").("James")

## & function notation
add_a_b = &(&1 + &2)
add_a_b.(1, 2)

## Exercise
Enum.map [1,2,3,4], fn x -> x + 2 end
Enum.map [1,2,3,4], &(&1 + 2)

Enum.each [1,2,3,4], fn x -> IO.inspect x end
Enum.each [1,2,3,4], &(IO.inspect &1)
