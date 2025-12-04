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
    |> Enum.map(fn
      "L" <> rest -> String.to_integer(rest) * -1
      "R" <> rest -> String.to_integer(rest)
      other -> raise "Invalid instruction: #{other}"
    end)
  end

  defp solve_part1(directions) do
    directions
    |> Enum.reduce({50, 0}, fn move, {current, zeros} ->
      next = Integer.mod(current + move, 100)
      {next, if(next == 0, do: zeros + 1, else: zeros)}
    end)
    |> elem(1)
  end

  defp solve_part2(directions) do
    directions
    |> Enum.reduce({50, 0}, fn move, {current, rotations} ->
      next = Integer.mod(current + move, 100)

      single_rotation =
        cond do
          current == 0 -> 0
          next == 0 -> 1
          next > current and move < 0 -> 1
          next < current and move > 0 -> 1
          true -> 0
        end

      {next, rotations + single_rotation + div(abs(move), 100)}
    end)
    |> elem(1)
  end
end
