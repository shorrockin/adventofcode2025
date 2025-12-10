defmodule AOC.Day10 do
  import Bitwise

  def part1(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      parts = String.split(line, " ")

      indicator_lights =
        Enum.at(parts, 0)
        |> String.slice(1..-2//1)
        |> String.graphemes()
        |> Enum.map(fn char -> if char == ".", do: "0", else: "1" end)
        |> Enum.join("")
        |> String.reverse()
        |> String.to_integer(2)

      schematics =
        Enum.drop(parts, 1)
        |> Enum.drop(-1)
        |> Enum.map(fn schematic ->
          schematic
          |> String.slice(1..-2//1)
          |> String.split(",")
          |> Enum.map(&String.trim/1)
          |> Enum.map(&String.to_integer/1)
          |> Enum.reduce(0, fn index, acc -> acc ||| 1 <<< index end)
        end)

      {indicator_lights, schematics}
    end)
    |> solve_part1()
  end

  def part2(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      parts = String.split(line, " ")

      joltage =
        Enum.at(parts, -1)
        |> String.slice(1..-2//1)
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)

      schematics =
        Enum.drop(parts, 1)
        |> Enum.drop(-1)
        |> Enum.map(fn schematic ->
          schematic
          |> String.slice(1..-2//1)
          |> String.split(",")
          |> Enum.map(&String.trim/1)
          |> Enum.map(&String.to_integer/1)
        end)

      {joltage, schematics}
    end)
    |> solve_part2()
  end

  defp solve_part1(machines) do
    machines
    |> Enum.map(fn machine -> fewest_presses_part1(machine, [0], 0) end)
    |> Enum.sum()
  end

  defp fewest_presses_part1({indicator_light, schematics}, values, presses) do
    if indicator_light in values do
      presses
    else
      values =
        for schematic <- schematics,
            val <- values,
            into: MapSet.new(),
            do: bxor(val, schematic)

      fewest_presses_part1({indicator_light, schematics}, values, presses + 1)
    end
  end

  defp solve_part2(machines) do
    machines
    |> Enum.map(fn {joltage, schematics} ->
      starting_value = List.to_tuple(List.duplicate(0, length(joltage)))
      joltage_tuple = List.to_tuple(joltage)
      fewest_presses_part2({joltage_tuple, schematics}, [starting_value], 0)
    end)
    |> Enum.sum()
  end

  defp fewest_presses_part2({joltage, schematics}, values, presses) do
    if joltage in values do
      presses
    else
      values =
        for schematic <- schematics,
            val <- values,
            new_val = apply_joltage_schematic(val, schematic),
            within_target?(new_val, joltage),
            into: MapSet.new(),
            do: new_val

      fewest_presses_part2({joltage, schematics}, values, presses + 1)
    end
  end

  defp apply_joltage_schematic(val, schematic) do
    Enum.reduce(schematic, val, fn i, acc ->
      put_elem(acc, i, elem(acc, i) + 1)
    end)
  end

  defp within_target?(counter, joltage) do
    within_target?(counter, joltage, 0, tuple_size(counter))
  end

  defp within_target?(_counter, _joltage, i, size) when i >= size, do: true

  defp within_target?(counter, joltage, i, size) do
    elem(counter, i) <= elem(joltage, i) and
      within_target?(counter, joltage, i + 1, size)
  end
end

