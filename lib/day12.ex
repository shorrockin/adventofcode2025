defmodule AOC.Day12 do
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  defp parse(input) do
    parts =
      input
      |> String.trim()
      |> String.split("\n\n")

    shapes =
      Enum.drop(parts, -1)
      |> Enum.map(fn shape ->
        shape
        |> String.split("\n")
        |> Enum.drop(1)
        |> Enum.join()
        |> String.graphemes()
        |> Enum.count(&(&1 == "#"))
      end)

    regions =
      Enum.at(parts, -1)
      |> String.split("\n")
      |> Enum.map(fn region ->
        parts = String.split(region, " ")

        dimension =
          Enum.at(parts, 0)
          |> String.slice(0..-2//1)
          |> String.split("x")
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()

        presents =
          Enum.drop(parts, 1)
          |> Enum.map(&String.to_integer/1)

        {dimension, presents}
      end)

    {shapes, regions}
  end

  defp solve_part1({shapes, regions}) do
    regions
    |> Enum.count(fn {{width, height}, presents} ->
      width * height >=
        Enum.zip(presents, shapes)
        |> Enum.map(fn {count, area} -> count * area end)
        |> Enum.sum()
    end)
  end
end
