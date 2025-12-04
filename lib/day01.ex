defmodule AOC.Day01 do
  @moduledoc """
  Advent of Code 2026 - Day 1
  """

  @doc """
  Solves part 1 of the puzzle.
  """
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @doc """
  Solves part 2 of the puzzle.
  """
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
  end

  defp solve_part1(lines) do
    # TODO: Implement part 1 solution
    0
  end

  defp solve_part2(lines) do
    # TODO: Implement part 2 solution
    0
  end
end
