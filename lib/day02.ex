defmodule AOC.Day02 do
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
    |> String.split(",", trim: true)
    |> Enum.map(fn line ->
      [from, to] = String.split(line, "-") |> Enum.map(&String.to_integer/1)
      %{from: from, to: to}
    end)
  end

  defp solve_part1(lines) do
    lines
    |> Enum.flat_map(fn range ->
      range.from..range.to
      |> Enum.map(&Integer.to_string/1)
      |> Enum.filter(fn val -> Integer.mod(String.length(val), 2) == 0 end)
      |> Enum.map(fn value -> String.split_at(value, div(String.length(value), 2)) end)
      |> Enum.filter(fn {left, right} -> left == right end)
      |> Enum.map(fn {left, right} -> String.to_integer(left <> right) end)
    end)
    |> Enum.sum()
  end

  defp solve_part2(lines) do
    lines
    |> Enum.flat_map(fn range ->
      range.from..range.to
      |> Enum.filter(&repeating_digits?(Integer.to_string(&1)))
    end)
    |> Enum.sum()
  end

  defp repeating_digits?(str) when byte_size(str) == 1, do: false

  defp repeating_digits?(str) do
    len = String.length(str)

    1..div(len, 2)
    |> Enum.filter(&(rem(len, &1) == 0))
    |> Enum.any?(&repeating_digits?(str, &1))
  end

  defp repeating_digits?(string, repeat_length) do
    length = String.length(string)
    pattern = String.slice(string, 0, repeat_length)
    String.duplicate(pattern, div(length, repeat_length)) == string
  end
end
