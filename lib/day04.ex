defmodule AOC.Day04 do
  alias AOC.Grid

  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Grid.from_lines()
  end

  defp solve_part1(grid) do
    accessible_coords(grid)
    |> Enum.count()
  end

  defp solve_part2(grid, remove_count \\ 0) do
    accessible = accessible_coords(grid)

    case accessible do
      [] ->
        remove_count

      _ ->
        updated =
          Enum.reduce(accessible, grid.data, fn {coord, _value}, acc_grid ->
            Map.put(acc_grid, coord, ".")
          end)

        solve_part2(%{grid | data: updated}, remove_count + length(accessible))
    end
  end

  defp accessible_coords(grid) do
    grid.data
    |> Enum.filter(fn {_coord, value} -> value == "@" end)
    |> Enum.filter(fn {coord, _value} ->
      Enum.count(Grid.neighbors(coord), fn neighbor ->
        Grid.get(grid, neighbor, ".") == "@"
      end) < 4
    end)
  end
end
