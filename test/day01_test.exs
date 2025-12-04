defmodule AOC.Day01Test do
  use ExUnit.Case
  doctest AOC.Day01

  @example_input File.read!("inputs/day01.example.txt")
  @puzzle_input File.read!("inputs/day01.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day01.part1(@example_input) == 3
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day01.part1(@puzzle_input) == 1105
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day01.part2(@example_input) == 6
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day01.part2(@puzzle_input) == 6599
    end
  end
end
