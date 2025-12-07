defmodule AOC.Grid do
  @moduledoc """
  A module for handling 2D grids.
  """

  @type t :: %__MODULE__{
          data: map(),
          width: non_neg_integer(),
          height: non_neg_integer()
        }

  defstruct data: %{}, width: 0, height: 0

  @doc """
  Creates a grid from a list of strings.
  Each string represents a row in the grid.
  """
  @spec from_lines([String.t()]) :: t()
  def from_lines(lines) do
    data =
      lines
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc2 ->
          Map.put(acc2, {x, y}, char)
        end)
      end)

    %__MODULE__{
      data: data,
      width: lines |> List.first() |> String.length(),
      height: length(lines)
    }
  end

  def get(%__MODULE__{data: data}, {x, y}, default \\ nil) do
    if Map.has_key?(data, {x, y}) do
      Map.get(data, {x, y})
    else
      default
    end
  end

  def in_bounds?(%__MODULE__{width: width, height: height}, {x, y}) do
    x >= 0 and x < width and y >= 0 and y < height
  end

  def offset({x, y}, x_offset, y_offset) do
    {x + x_offset, y + y_offset}
  end

  def cardinal_neighbors({x, y}) do
    [
      {x, y - 1},
      {x + 1, y},
      {x, y + 1},
      {x - 1, y}
    ]
  end

  def neighbors({x, y}) do
    [
      {x, y - 1},
      {x + 1, y},
      {x, y + 1},
      {x - 1, y},
      {x + 1, y + 1},
      {x - 1, y + 1},
      {x + 1, y - 1},
      {x - 1, y - 1}
    ]
  end
end
