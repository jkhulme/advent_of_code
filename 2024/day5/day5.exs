defmodule Day5 do
  def part1(input_path) do
    [rules, updates] = parseInput(input_path)
    Enum.filter(updates, fn update -> inOrder?(update, [], rules) end)
      |> Enum.map(&Enum.at(&1, trunc(Enum.count(&1) / 2)))
      |> Enum.sum
  end

  def part2(input_path) do
    [rules, updates] = parseInput(input_path)
    Enum.reject(updates, fn update -> inOrder?(update, [], rules) end)
      |> Enum.map(fn update -> Enum.sort(update, fn x, y -> Enum.member?(Map.get(rules, x, []), y) end) end)
      |> Enum.map(&Enum.at(&1, trunc(Enum.count(&1) / 2)))
      |> Enum.sum
  end

  defp inOrder?([], _, _) do
    true
  end
  defp inOrder?([p | pages], prevPages, rules) do
    case Enum.any?(prevPages, fn prev -> Enum.member?(Map.get(rules, p, []), prev) end) do
      true -> false
      _ -> inOrder?(pages, [p | prevPages], rules)
    end
  end


  defp parseInput(input_path) do
    [rules, updates] = File.read!(input_path)
      |> String.trim()
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n"))

    [
      rulesMap(Enum.map(rules, fn rule -> String.split(rule, "|") |> Enum.map(&String.to_integer/1) end), %{}),
      Enum.map(updates, fn update -> String.split(update, ",") |> Enum.map(&String.to_integer/1) end)
    ]
  end

  defp rulesMap([], rMap) do
    rMap
  end
  defp rulesMap([[p, o] | rules], rMap) do
    rulesMap(
      rules,
      Map.update(rMap, p, [o], fn v -> [o | v] end)
    )
  end
end

IO.puts(Day5.part1("day5_input.txt"))
IO.puts(Day5.part2("day5_input.txt"))
