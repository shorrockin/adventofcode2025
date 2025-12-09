defmodule AOC.Day09Test do
  use ExUnit.Case
  doctest AOC.Day09

  @example_input File.read!("inputs/day09.example.txt")
  @puzzle_input File.read!("inputs/day09.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day09.part1(@example_input) == 50
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day09.part1(@puzzle_input) == 4_752_484_112
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day09.part2(@example_input) == 24
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day09.part2(@puzzle_input) == 1_465_767_840
    end
  end
end
