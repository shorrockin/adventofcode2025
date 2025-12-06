defmodule AOC.Day06 do
  def part1(input) do
    lines =
      input
      |> String.trim()
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, " ", trim: true) end)

    Enum.at(lines, -1)
    |> Enum.with_index()
    |> Enum.map(fn {op, index} ->
      Enum.drop(lines, -1)
      |> Enum.map(fn line -> String.to_integer(Enum.at(line, index)) end)
      |> apply_operator(op)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    # extract out the lines, removing the last line which is a 
    # empty line because we do not want to trim the input
    lines =
      input
      |> String.split("\n", trim: false)
      |> Enum.drop(-1)
      |> Enum.map(&String.reverse/1)

    # because we've reversed the logic above we can iterate through
    # the columns and convert each column into a integer. 
    # - if the column is empty, this represents a logical break in the operator
    # - we can convert this to a newline character to split on later
    # - the output of this will be [[nums for op1], [nums for op2], ...]
    values =
      0..(String.length(Enum.at(lines, 0)) - 1)
      |> Enum.map(fn column ->
        lines
        |> Enum.drop(-1)
        |> Enum.map(fn line -> String.at(line, column) end)
        |> Enum.join("")
        |> String.trim()
      end)
      |> Enum.map(fn char -> if char == "", do: "\n", else: char end)
      |> Enum.join(" ")
      |> String.split("\n", trim: true)
      |> Enum.map(fn nums ->
        nums
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    # now that we have the values, we can apply the operators from the last line
    # and apply the results similar to part 1
    Enum.at(lines, -1)
    |> String.split(" ", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {op, index} -> apply_operator(Enum.at(values, index), op) end)
    |> Enum.sum()
  end

  defp apply_operator(nums, "+"), do: Enum.sum(nums)
  defp apply_operator(nums, "*"), do: Enum.product(nums)
end
