defmodule AOC.Day12Test do
  use ExUnit.Case
  doctest AOC.Day12

  # @example_input File.read!("inputs/day12.example.txt")
  @puzzle_input File.read!("inputs/day12.txt")

  describe "part1/1" do
    # test "example input" do
    #   assert AOC.Day12.part1(@example_input) == 2
    # end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day12.part1(@puzzle_input) == 538
    end
  end
end
