defmodule PropertyBasedTestingTest do
  @moduledoc false

  use ExUnit.Case, async: true
  use ExUnitProperties
  doctest PropertyBasedTesting

  describe "unique/1" do
    property "when every element in the list is the same element, resulting list will have length 1 for non empty lists" do
      check all(value <- term(), list <- list_of(constant(value), min_length: 1)) do
        assert length(PropertyBasedTesting.unique(list)) == 1
      end
    end

    property "when every element is already unique, the same list should be returned" do
      check all(list <- uniq_list_of(term())) do
        assert PropertyBasedTesting.unique(list) == list
      end
    end

    property "removes duplicates from list" do
      check all(list <- list_of(term())) do
        expected = list |> MapSet.new() |> MapSet.to_list() |> Enum.sort()
        actual = list |> PropertyBasedTesting.unique() |> Enum.sort()
        assert actual == expected
      end
    end
  end
end
