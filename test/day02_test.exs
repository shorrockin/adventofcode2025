defmodule AOC.Day02Test do
  use ExUnit.Case
  doctest AOC.Day02

  @example_input File.read!("inputs/day02.example.txt")
  @puzzle_input File.read!("inputs/day02.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day02.part1(@example_input) == 1_227_775_554
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day02.part1(@puzzle_input) == 19_128_774_598
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day02.part2(@example_input) == 4_174_379_265
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day02.part2(@puzzle_input) == 21_932_258_645
    end
  end
end
