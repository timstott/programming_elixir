defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 uniq cards" do
    deck_size = Cards.create_deck |> Enum.uniq |> length
    assert deck_size == 20
  end

  test "create_hand makes a hand with the given hand size" do
    { hand, deck } = Cards.create_hand(5)
    assert length(hand) == 5
  end
end
