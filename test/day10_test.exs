defmodule AOC.Day10Test do
  use ExUnit.Case
  doctest AOC.Day10

  @example_input File.read!("inputs/day10.example.txt")
  @puzzle_input File.read!("inputs/day10.txt")

  describe "part1/1" do
    test "example input" do
      assert AOC.Day10.part1(@example_input) == 7
    end

    @tag :puzzle_input
    test "puzzle input" do
      assert AOC.Day10.part1(@puzzle_input) == 461
    end
  end

  describe "part2/1" do
    test "example input" do
      assert AOC.Day10.part2(@example_input) == 33
    end

    # @tag :puzzle_input
    # @tag timeout: :infinity
    # test "puzzle input" do
    #   result = AOC.Day10.part2(@puzzle_input)
    #   IO.puts("Day 10 Part 2: #{result}")
    #   IO.puts(" - 16579 is too high")
    #   # assert result == expected_result
    # end
  end
end
