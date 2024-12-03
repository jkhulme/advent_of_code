defmodule Day2 do
  def part1(input_path) do
    parseInput(input_path)
      |> Enum.filter(fn report -> checkSafety(report) end)
      |> Enum.count
  end

  def part2(input_path) do
    parseInput(input_path)
      |> Enum.map(fn
        report -> combinations(report, [], [])
          |> Enum.any?(fn report -> checkSafety(report) end)
      end)
      |> Enum.count(fn report -> report end)
  end

  defp combinations([], combos, _) do
    combos
  end
  defp combinations([x|xs], combos, head) do
    combinations(xs, [head ++ xs | combos], head ++ [x])
  end

  defp checkSafety([x, y | levels]) do
    case abs(x - y) do
      1 -> checkSafety([y | levels], y - x < 0)
      2 -> checkSafety([y | levels], y - x < 0)
      3 -> checkSafety([y | levels], y - x < 0)
      _ -> false
    end
  end
  defp checkSafety([_ | []], _) do
    true
  end
  defp checkSafety([x, y | levels], true) do # true > 0
    case x - y do
      1 -> checkSafety([y | levels], true)
      2 -> checkSafety([y | levels], true)
      3 -> checkSafety([y | levels], true)
      _ -> false
    end
  end
  defp checkSafety([x, y | levels], false) do # false < 0
    case x - y do
      -1 -> checkSafety([y | levels], false)
      -2 -> checkSafety([y | levels], false)
      -3 -> checkSafety([y | levels], false)
      _ -> false
    end
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(
        fn report -> String.split(report) |> Enum.map(&String.to_integer/1)
      end)
  end
end

IO.puts(Day2.part1("day2_input.txt"))
IO.puts(Day2.part2("day2_input.txt"))
