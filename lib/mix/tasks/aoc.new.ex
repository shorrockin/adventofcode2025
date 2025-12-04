defmodule Mix.Tasks.Aoc.New do
  @moduledoc """
  Creates template files for a new Advent of Code day.

  ## Usage

      mix aoc.new <day_number>

  ## Examples

      mix aoc.new 1
      mix aoc.new 15
  """
  @shortdoc "Creates template files for a new day"

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    case args do
      [day] ->
        day_num = String.to_integer(day)
        create_day(day_num)

      _ ->
        Mix.shell().error("Usage: mix aoc.new <day_number>")
        Mix.shell().error("Example: mix aoc.new 5")
    end
  end

  defp create_day(day) when day < 1 or day > 25 do
    Mix.shell().error("Day must be between 1 and 25")
  end

  defp create_day(day) do
    day_str = String.pad_leading(Integer.to_string(day), 2, "0")

    lib_file = "lib/day#{day_str}.ex"
    test_file = "test/day#{day_str}_test.exs"
    input_file = "inputs/day#{day_str}.txt"

    if File.exists?(lib_file) do
      Mix.shell().error("#{lib_file} already exists!")
      System.halt(1)
    end

    Mix.shell().info("Creating Day #{day_str} files...")

    # Create solution file
    File.write!(lib_file, solution_template(day_str))
    Mix.shell().info("  Created #{lib_file}")

    # Create test file
    File.write!(test_file, test_template(day_str))
    Mix.shell().info("  Created #{test_file}")

    # Create input file
    File.write!(input_file, "# Paste your puzzle input here\n")
    Mix.shell().info("  Created #{input_file}")

    Mix.shell().info("")
    Mix.shell().info("Day #{day_str} template created successfully!")
    Mix.shell().info("")
    Mix.shell().info("Next steps:")
    Mix.shell().info("  1. Add your puzzle input to #{input_file}")
    Mix.shell().info("  2. Run: mix test.watch test/day#{day_str}_test.exs")
    Mix.shell().info("  3. Start solving!")
  end

  defp solution_template(day_str) do
    """
    defmodule AOC.Day#{day_str} do
      @moduledoc \"\"\"
      Advent of Code 2026 - Day #{String.to_integer(day_str)}
      \"\"\"

      @doc \"\"\"
      Solves part 1 of the puzzle.
      \"\"\"
      def part1(input) do
        input
        |> parse()
        |> solve_part1()
      end

      @doc \"\"\"
      Solves part 2 of the puzzle.
      \"\"\"
      def part2(input) do
        input
        |> parse()
        |> solve_part2()
      end

      defp parse(input) do
        input
        |> String.trim()
        |> String.split("\\n", trim: true)
      end

      defp solve_part1(lines) do
        # TODO: Implement part 1 solution
        0
      end

      defp solve_part2(lines) do
        # TODO: Implement part 2 solution
        0
      end
    end
    """
  end

  defp test_template(day_str) do
    """
    defmodule AOC.Day#{day_str}Test do
      use ExUnit.Case
      doctest AOC.Day#{day_str}

      @example_input \"\"\"
      \"\"\"

      @puzzle_input File.read!("inputs/day#{day_str}.txt")

      describe "part1/1" do
        test "example input" do
          # assert AOC.Day#{day_str}.part1(@example_input) == expected_result
        end

        @tag :puzzle_input
        test "puzzle input" do
          result = AOC.Day#{day_str}.part1(@puzzle_input)
          IO.puts("Day #{day_str} Part 1: \#{result}")
          # assert result == expected_result
        end
      end

      describe "part2/1" do
        test "example input" do
          # assert AOC.Day#{day_str}.part2(@example_input) == expected_result
        end

        @tag :puzzle_input
        test "puzzle input" do
          result = AOC.Day#{day_str}.part2(@puzzle_input)
          IO.puts("Day #{day_str} Part 2: \#{result}")
          # assert result == expected_result
        end
      end
    end
    """
  end
end
