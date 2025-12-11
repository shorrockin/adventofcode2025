defmodule AOC.Day11 do
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
    |> Map.new(fn line ->
      [device, outputs] = String.split(line, ": ")
      {device, String.split(outputs, " ")}
    end)
  end

  defp solve_part1(devices) do
    count_paths_from("you", devices, MapSet.new()) |> elem(0)
  end

  defp solve_part2(devices) do
    count_paths_from("svr", devices, MapSet.new(["dac", "fft"])) |> elem(0)
  end

  defp count_paths_from(device, devices, required, seen \\ MapSet.new(), memo \\ %{}) do
    state = {device, seen}

    case Map.fetch(memo, state) do
      {:ok, cached} ->
        {cached, memo}

      :error when device == "out" ->
        count = if MapSet.equal?(seen, required), do: 1, else: 0
        {count, Map.put(memo, state, count)}

      :error ->
        outputs = Map.get(devices, device, [])

        {count, memo} =
          Enum.reduce(outputs, {0, memo}, fn output, {acc_count, acc_cache} ->
            # only tracking visited nodes if they're required
            seen =
              if MapSet.member?(required, output) do
                MapSet.put(seen, output)
              else
                seen
              end

            {paths, memo} =
              count_paths_from(output, devices, required, seen, acc_cache)

            {acc_count + paths, memo}
          end)

        {count, Map.put(memo, state, count)}
    end
  end
end
