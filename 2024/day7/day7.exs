defmodule Day7 do
  def part1(input_path) do
    parseInput(input_path)
     |> Enum.filter(fn [total, input] -> possibleCalculation?(total, input) end)
     |> Enum.map(&Enum.at(&1, 0))
     |> Enum.sum()
  end

  def part2(input_path) do
    parseInput(input_path)
      |> Enum.filter(fn [total, input] -> possibleCalculationP2?(total, input) end)
      |> Enum.map(&Enum.at(&1, 0))
      |> Enum.sum()
  end

  defp possibleCalculation?(target, [x | []]) do
    x == target
  end
  defp possibleCalculation?(target, [x, y | input]) do
    possibleCalculation?(target, [x + y | input]) || possibleCalculation?(target, [x * y | input])
  end

  defp possibleCalculationP2?(target, [x | []]) do
    x == target
  end
  defp possibleCalculationP2?(target, [x, y | input]) do
    possibleCalculationP2?(target, [x + y | input])
      || possibleCalculationP2?(target, [x * y | input])
      || possibleCalculationP2?(target, [concat_integers(x, y) | input])
  end

  defp concat_integers(x, y) do
    [Integer.to_string(x), Integer.to_string(y)]
      |> Enum.join("")
      |> String.to_integer()
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, ": "))
      |> Enum.map(fn [total, input] -> [
        String.to_integer(total),
        String.split(input, " ") |> Enum.map(&String.to_integer/1)
      ] end)
  end
end

IO.puts(Day7.part1("day7_input.txt"))
IO.puts(Day7.part2("day7_input.txt"))
