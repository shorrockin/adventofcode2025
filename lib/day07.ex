defmodule AOC.Day07 do
  alias AOC.Grid
  alias AOC.Queue

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
    |> Grid.from_lines()
  end

  defp init_queue(grid) do
    start = {div(grid.width, 2), 0}
    if Grid.get(grid, start) != "S", do: raise("unexpected start position")

    queue = Queue.new()
    Queue.push(queue, start)
  end

  defp solve_part1(grid) do
    process_part1(grid, init_queue(grid), Map.new()).data
    |> Enum.filter(fn {_coord, value} -> value == "x" end)
    |> Enum.count()
  end

  defp process_part1(grid, queue, visited) do
    case Queue.pop(queue) do
      # queue is empty
      nil ->
        grid

      # we've already visited this node, don't reprocess
      {coord, queue} when is_map_key(visited, coord) ->
        process_part1(grid, queue, visited)

      # mark as visited & recurse
      {coord, queue} ->
        case Grid.get(grid, coord) do
          elem when elem == "." or elem == "S" ->
            process_part1(
              grid,
              Queue.push(queue, Grid.offset(coord, 0, 1)),
              Map.put(visited, coord, true)
            )

          "^" ->
            process_part1(
              %{grid | data: Map.put(grid.data, coord, "x")},
              Queue.push(queue, Grid.offset(coord, -1, 0))
              |> Queue.push(Grid.offset(coord, 1, 0)),
              Map.put(visited, coord, true)
            )

          _ ->
            # everything else, continue to process the entries
            # in the queue until we exhast
            process_part1(grid, queue, visited)
        end
    end
  end

  defp solve_part2(grid) do
    {count, _memo} = process_part2(grid, init_queue(grid))
    count
  end

  defp process_part2(grid, queue, count \\ 0, memo \\ %{}) do
    case Queue.pop(queue) do
      nil ->
        {count, memo}

      {coord, _queue} when is_map_key(memo, coord) ->
        {Map.get(memo, coord), memo}

      {coord, queue} ->
        case Grid.get(grid, coord) do
          elem when elem == "." or elem == "S" ->
            process_part2(
              grid,
              Queue.push(queue, Grid.offset(coord, 0, 1)),
              0,
              memo
            )

          "^" ->
            {left_count, memo} =
              process_part2(
                grid,
                Queue.push(queue, Grid.offset(coord, -1, 0)),
                0,
                memo
              )

            {right_count, memo} =
              process_part2(
                grid,
                Queue.push(queue, Grid.offset(coord, 1, 0)),
                0,
                memo
              )

            result = count + left_count + right_count
            {result, Map.put(memo, coord, result)}

          nil ->
            {1, memo}
        end
    end
  end
end
