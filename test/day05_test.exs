defmodule AOC.Day05Test do
  use ExUnit.Case
  doctest AOC.Day05

  @example_input File.read!("inputs/day05.example.txt")
  @puzzle_input File.read!("inputs/day05.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day05.part1(@example_input) == 3
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day05.part1(@puzzle_input) == 821
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day05.part2(@example_input) == 14
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day05.part2(@puzzle_input) == 344_771_884_978_261
    end
  end
end
