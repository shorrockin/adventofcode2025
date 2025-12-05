defmodule AOC.Day03 do
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
    |> Enum.map(fn line ->
      String.graphemes(line)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp solve_part1(banks) do
    banks
    |> Enum.map(fn bank ->
      major = bank |> Enum.drop(-1) |> Enum.max()
      major_index = Enum.find_index(bank, fn x -> x == major end)
      minor = Enum.drop(bank, major_index + 1) |> Enum.max()
      major * 10 + minor
    end)
    |> Enum.sum()
  end

  defp solve_part2(banks) do
    banks
    |> Enum.map(fn bank ->
      Enum.reduce(12..1//-1, {[], 0}, fn max_size, {values, offset} ->
        {value, index} = max_value_index_in_bank(bank, offset, length(bank) - max_size)
        new_offset = index + 1
        new_values = [value | values]
        {new_values, new_offset}
      end)
      |> elem(0)
      |> Enum.with_index()
      |> Enum.reduce(0, fn {value, index}, acc ->
        power = :math.pow(10, index)
        acc + value * trunc(power)
      end)
    end)
    |> Enum.sum()
  end

  defp max_value_index_in_bank(bank, from_index, to_index) do
    bank
    |> Enum.slice(from_index..to_index)
    |> Enum.with_index(from_index)
    |> Enum.max_by(fn {value, _index} -> value end)
  end
end
