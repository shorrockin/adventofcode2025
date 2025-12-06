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
    input
    |> String.split("\n", trim: false)
    |> Enum.drop(-1)
    |> Enum.map(&String.reverse/1)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.reject(fn line -> Enum.all?(line, &(&1 == " ")) end)
    |> Enum.reduce(%{sum: 0, numbers: []}, fn line, acc ->
      number =
        line
        |> Enum.drop(-1)
        |> Enum.join("")
        |> String.trim()
        |> String.to_integer()

      case Enum.at(line, -1) do
        " " ->
          %{sum: acc.sum, numbers: [number | acc.numbers]}

        operator ->
          result = apply_operator([number | acc.numbers], operator)
          %{sum: result + acc.sum, numbers: []}
      end
    end)
    |> Map.get(:sum)
  end

  defp apply_operator(nums, "+"), do: Enum.sum(nums)
  defp apply_operator(nums, "*"), do: Enum.product(nums)
end
