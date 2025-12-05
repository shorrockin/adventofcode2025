defmodule AOC.Day04Test do
  use ExUnit.Case
  doctest AOC.Day04

  @example_input File.read!("inputs/day04.example.txt")
  @puzzle_input File.read!("inputs/day04.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day04.part1(@example_input) == 13
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day04.part1(@puzzle_input) == 1533
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day04.part2(@example_input) == 43
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day04.part2(@puzzle_input) == 9206
    end
  end
end
