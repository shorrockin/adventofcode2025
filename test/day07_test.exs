defmodule AOC.Day07Test do
  use ExUnit.Case
  doctest AOC.Day07

  @example_input File.read!("inputs/day07.example.txt")
  @puzzle_input File.read!("inputs/day07.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day07.part1(@example_input) == 21
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day07.part1(@puzzle_input) == 1660
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day07.part2(@example_input) == 40
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day07.part2(@puzzle_input) == 305_999_729_392_659
    end
  end
end
