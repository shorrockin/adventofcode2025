defmodule AOC.Day11Test do
  use ExUnit.Case
  doctest AOC.Day11

  @example_input File.read!("inputs/day11.example.txt")
  @example_input2 File.read!("inputs/day11.example2.txt")
  @puzzle_input File.read!("inputs/day11.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day11.part1(@example_input) == 5
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day11.part1(@puzzle_input) == 701
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day11.part2(@example_input2) == 2
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day11.part2(@puzzle_input) == 390_108_778_818_526
    end
  end
end
