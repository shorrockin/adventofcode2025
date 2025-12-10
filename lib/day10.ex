defmodule AOC.Day10 do
  @moduledoc """
  Part 2 uses Integer Linear Programming (ILP) to find the minimum button presses.

  The problem: each button increments certain counter indices. We need to find
  how many times to press each button so all counters reach their targets.

  This maps to ILP as:
  - Variables: x0, x1, x2... = number of times each button is pressed
  - Objective: minimize x0 + x1 + x2 + ... (fewest total presses)
  - Constraints: for each counter index, the sum of button presses that
    affect that index must equal the target value

  We use the HiGHS solver (via the HIGHS_PATH env var) to solve this.
  """

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

      buttons =
        Enum.drop(parts, 1)
        |> Enum.drop(-1)
        |> Enum.map(fn button ->
          button
          |> String.slice(1..-2//1)
          |> String.split(",")
          |> Enum.map(&String.trim/1)
          |> Enum.map(&String.to_integer/1)
          |> Enum.reduce(0, fn index, acc -> acc ||| 1 <<< index end)
        end)

      {indicator_lights, buttons}
    end)
    |> solve_part1()
  end

  defp solve_part1(machines) do
    machines
    |> Enum.map(fn machine -> fewest_presses_part1(machine, [0], 0) end)
    |> Enum.sum()
  end

  defp fewest_presses_part1({indicator_light, buttons}, values, presses) do
    if indicator_light in values do
      presses
    else
      values =
        for button <- buttons,
            val <- values,
            into: MapSet.new(),
            do: bxor(val, button)

      fewest_presses_part1({indicator_light, buttons}, values, presses + 1)
    end
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

      buttons =
        Enum.drop(parts, 1)
        |> Enum.drop(-1)
        |> Enum.map(fn button ->
          button
          |> String.slice(1..-2//1)
          |> String.split(",")
          |> Enum.map(&String.trim/1)
          |> Enum.map(&String.to_integer/1)
        end)

      {joltage, buttons}
    end)
    |> solve_part2()
  end

  defp solve_part2(machines) do
    machines
    |> Enum.map(&solve_ilp/1)
    |> Enum.sum()
  end

  # Find minimum total button presses using Integer Linear Programming
  defp solve_ilp({targets, buttons}) do
    lp_problem = build_lp_problem(targets, buttons)
    solution = run_highs_solver(lp_problem)
    sum_variable_values(solution)
  end

  defp build_lp_problem(targets, buttons) do
    var_names = for i <- 0..(length(buttons) - 1), do: "x#{i}"

    # Objective: minimize total presses (x0 + x1 + x2 + ...)
    objective = Enum.join(var_names, " + ")

    # Constraints: for each counter index, button presses affecting it must sum to target
    # Example: if buttons 0 and 2 affect index 1, and target[1] is 5:
    #   x0 + x2 = 5
    constraints =
      targets
      |> Enum.with_index()
      |> Enum.map(fn {target, index} ->
        terms =
          buttons
          |> Enum.with_index()
          |> Enum.filter(fn {button_indices, _} -> index in button_indices end)
          |> Enum.map(fn {_, button_num} -> "x#{button_num}" end)
          |> Enum.join(" + ")

        "  c#{index}: #{terms} = #{target}"
      end)

    # Bounds: can't press a button negative times
    bounds = Enum.map(var_names, fn v -> "  #{v} >= 0" end)

    # General: variables must be integers (can't press a button 2.5 times)
    integers = Enum.join(var_names, " ")

    """
    Minimize
    #{objective}
    Subject To
    #{Enum.join(constraints, "\n")}
    Bounds
    #{Enum.join(bounds, "\n")}
    General
    #{integers}
    End
    """
  end

  defp run_highs_solver(lp_problem) do
    model_path = Path.join(System.tmp_dir!(), "model_#{:rand.uniform(1_000_000)}.lp")
    solution_path = Path.join(System.tmp_dir!(), "solution_#{:rand.uniform(1_000_000)}.sol")

    File.write!(model_path, lp_problem)

    highs_path = System.get_env("HIGHS_PATH") || "highs"
    {_output, 0} = System.cmd(highs_path, [model_path, "--solution_file", solution_path])

    solution = File.read!(solution_path)

    File.rm(model_path)
    File.rm(solution_path)

    solution
  end

  defp sum_variable_values(solution) do
    solution
    |> String.split("\n")
    |> Enum.filter(&String.starts_with?(&1, "x"))
    |> Enum.map(fn line ->
      [_var, val] = String.split(line)
      String.to_integer(val)
    end)
    |> Enum.sum()
  end
end
