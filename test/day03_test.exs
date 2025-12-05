defmodule AOC.Day03Test do
  use ExUnit.Case
  doctest AOC.Day03

  @example_input File.read!("inputs/day03.example.txt")
  @puzzle_input File.read!("inputs/day03.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day03.part1(@example_input) == 357
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day03.part1(@puzzle_input) == 17100
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day03.part2(@example_input) == 3_121_910_778_619
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day03.part2(@puzzle_input) == 170_418_192_256_861
    end
  end
end
