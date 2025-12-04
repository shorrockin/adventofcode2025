defmodule AOC.Day01Test do
  use ExUnit.Case
  doctest AOC.Day01

  @example_input """
  """

  @puzzle_input File.read!("inputs/day01.txt")

  describe "part1/1" do
    test "example input" do
      # assert AOC.Day01.part1(@example_input) == expected_result
    end

    @tag :puzzle_input
    test "puzzle input" do
      result = AOC.Day01.part1(@puzzle_input)
      IO.puts("Day 01 Part 1: #{result}")
      # assert result == expected_result
    end
  end

  describe "part2/1" do
    test "example input" do
      # assert AOC.Day01.part2(@example_input) == expected_result
    end

    @tag :puzzle_input
    test "puzzle input" do
      result = AOC.Day01.part2(@puzzle_input)
      IO.puts("Day 01 Part 2: #{result}")
      # assert result == expected_result
    end
  end
end
