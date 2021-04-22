defmodule PropertyBasedTesting do
  @moduledoc false

  defp unique(list, unique_list, seen_elements) do
    case list do
      [] ->
        []

      [head | tail] ->
        if MapSet.member?(seen_elements, head) do
          unique(tail, unique_list, seen_elements)
        else
          [head | unique(tail, unique_list, MapSet.put(seen_elements, head))]
        end
    end
  end

  @doc """
  Removes duplicated elements from list

  ## Examples

      iex> [1] |> PropertyBasedTesting.unique()
      [1]

      iex> [] |> PropertyBasedTesting.unique()
      []

      iex> [1, 1, 1] |> PropertyBasedTesting.unique()
      [1]

      iex> [1, 2, 2, 3] |> PropertyBasedTesting.unique()
      [1, 2, 3]
  """
  def unique(list) do
    unique(list, [], MapSet.new())
  end
end
