defmodule AOC.Day06Test do
  use ExUnit.Case
  doctest AOC.Day06

  @example_input File.read!("inputs/day06.example.txt")
  @puzzle_input File.read!("inputs/day06.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day06.part1(@example_input) == 4_277_556
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day06.part1(@puzzle_input) == 4_771_265_398_012
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day06.part2(@example_input) == 3_263_827
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day06.part2(@puzzle_input) == 10_695_785_245_101
    end
  end
end
