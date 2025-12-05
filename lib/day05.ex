defmodule AOC.Day05 do
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
    [ranges, ingredients] =
      input
      |> String.trim()
      |> String.split("\n\n", trim: true)

    ranges =
      ranges
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [from, to] = String.split(line, "-") |> Enum.map(&String.to_integer/1)
        from..to
      end)

    ingredients =
      ingredients
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)

    {ranges, ingredients}
  end

  defp solve_part1({ranges, ingredients}) do
    ingredients
    |> Enum.count(fn ingredient ->
      Enum.any?(ranges, fn range -> ingredient in range end)
    end)
  end

  defp solve_part2({ranges, _ingredients}) do
    merge_ranges(ranges)
    |> Enum.map(fn range -> range.last - range.first + 1 end)
    |> Enum.sum()
  end

  defp merge_ranges(ranges) do
    ranges
    |> Enum.sort_by(& &1.first)
    |> Enum.reduce([], fn range, acc ->
      case acc do
        [] ->
          [range]

        [last | rest] ->
          # overlaps or is adjacent
          if range.first <= last.last + 1 do
            merged = last.first..max(last.last, range.last)
            [merged | rest]
          else
            [range, last | rest]
          end
      end
    end)
  end
end
