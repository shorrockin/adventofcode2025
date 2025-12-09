defmodule AOC.Day09 do
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
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
    |> Enum.map(fn line ->
      [x, y] = String.split(line, ",") |> Enum.map(&String.to_integer/1)
      {x, y}
    end)
  end

  defp solve_part1(coords) do
    all_pairs(coords)
    |> Enum.map(fn {l, r} -> distance(l, r) end)
    |> Enum.max()
  end

  defp solve_part2(coords) do
    poly = Enum.zip(coords, Enum.drop(coords, 1) ++ [Enum.at(coords, 0)])

    all_pairs(coords)
    |> Enum.map(fn {l, r} -> {distance(l, r), l, r} end)
    |> Enum.sort_by(fn {d, _l, _r} -> -d end)
    |> Enum.find_value(fn {d, {x1, y1}, {x2, y2}} ->
      if inside?({x1, y1}, {x2, y2}, poly), do: d
    end)
  end

  defp inside?({x1, y1}, {x2, y2}, poly) do
    min_x = min(x1, x2)
    max_x = max(x1, x2)
    min_y = min(y1, y2)
    max_y = max(y1, y2)

    not Enum.any?(poly, fn {{sx1, sy1}, {sx2, sy2}} ->
      segment_intersects_interior?(
        {sx1, sy1},
        {sx2, sy2},
        min_x,
        max_x,
        min_y,
        max_y
      )
    end)
  end

  # true if overlaps rect's interior, must be strictly inside
  defp segment_intersects_interior?(
         {sx1, sy1},
         {sx2, sy2},
         min_x,
         max_x,
         min_y,
         max_y
       ) do
    s_min_x = min(sx1, sx2)
    s_max_x = max(sx1, sx2)
    s_min_y = min(sy1, sy2)
    s_max_y = max(sy1, sy2)

    s_max_x > min_x and
      s_min_x < max_x and
      s_max_y > min_y and
      s_min_y < max_y
  end

  defp all_pairs(coords) do
    for {item1, i} <- Enum.with_index(coords),
        {item2, j} <- Enum.with_index(coords),
        i < j,
        do: {item1, item2}
  end

  defp distance({x1, y1}, {x2, y2}) do
    (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
  end
end
