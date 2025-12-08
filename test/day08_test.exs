defmodule AOC.Day08Test do
  use ExUnit.Case
  doctest AOC.Day08

  @example_input File.read!("inputs/day08.example.txt")
  @puzzle_input File.read!("inputs/day08.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day08.part1(@example_input, 10) == 40
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day08.part1(@puzzle_input, 1000) == 122_636
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day08.part2(@example_input) == 25_272
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day08.part2(@puzzle_input) == 9_271_575_747
    end
  end
end
