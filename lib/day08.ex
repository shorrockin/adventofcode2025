defmodule AOC.Day08 do
  def part1(input, circuit_size) do
    input
    |> parse()
    |> solve_part1(circuit_size)
  end

  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, ",", trim: true) end)
    |> Enum.map(fn parts -> parts |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn [x, y, z] -> %{x: x, y: y, z: z} end)
  end

  defp all_pairs(list) do
    for {item1, i} <- Enum.with_index(list),
        {item2, j} <- Enum.with_index(list),
        i < j,
        do: {item1, item2}
  end

  defp solve_part1(coords, circuit_size) do
    all_pairs(coords)
    |> Enum.map(fn {left, right} -> {distance(left, right), left, right} end)
    |> Enum.sort_by(fn {dist, _left, _right} -> dist end)
    |> Enum.take(circuit_size)
    |> Enum.reduce(Map.new(), fn {distance, left, right}, circuits ->
      connect(circuits, left, right, distance)
    end)
    |> Enum.group_by(fn {_key, value} -> value end, fn {key, _value} -> key end)
    |> Enum.sort_by(fn {_key, value} -> -length(value) end)
    |> Enum.take(3)
    |> Enum.map(fn {_key, value} -> length(value) end)
    |> Enum.product()
  end

  defp solve_part2(coords) do
    all_pairs(coords)
    |> Enum.map(fn {left, right} -> {distance(left, right), left, right} end)
    |> Enum.sort_by(fn {dist, _left, _right} -> dist end)
    |> Enum.reduce_while(Map.new(), fn {distance, left, right}, circuits ->
      circuits = connect(circuits, left, right, distance)

      if map_size(circuits) == length(coords) and all_same_values?(circuits) do
        {:halt, left.x * right.x}
      else
        {:cont, circuits}
      end
    end)
  end

  defp connect(circuits, left, right, name) do
    case {Map.get(circuits, left), Map.get(circuits, right)} do
      {nil, nil} -> Map.put(circuits, right, name) |> Map.put(left, name)
      {circuit, nil} -> Map.put(circuits, right, circuit)
      {nil, circuit} -> Map.put(circuits, left, circuit)
      {_l, _r} -> merge(circuits, left, right)
    end
  end

  defp all_same_values?(map) do
    case Map.values(map) do
      [] -> true
      [first | rest] -> Enum.all?(rest, &(&1 == first))
    end
  end

  defp distance(%{x: x1, y: y1, z: z1}, %{x: x2, y: y2, z: z2}) do
    dx = x2 - x1
    dy = y2 - y1
    dz = z2 - z1
    dx * dx + dy * dy + dz * dz
  end

  defp merge(acc, left, right) do
    left_circuit = Map.get(acc, left)
    right_circuit = Map.get(acc, right)

    if left_circuit == right_circuit do
      acc
    else
      for {key, value} <- acc, into: %{} do
        if value == right_circuit, do: {key, left_circuit}, else: {key, value}
      end
    end
  end
end
