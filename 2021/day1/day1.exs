defmodule Day1 do
  def part1() do
    parseInput() |> depthPairs() |> countIncreasing()
  end

  def part2() do
    x = parseInput()
    Enum.zip([x, Enum.drop(x, 1), Enum.drop(x, 2)]) |> Enum.map(fn x -> Tuple.sum(x) end) |> depthPairs() |> countIncreasing()
  end

  defp depthPairs(depths) do
    Enum.zip([depths, Enum.drop(depths, 1)])
  end

  defp countIncreasing(depthTuples) do
    Enum.filter(depthTuples, fn (t) -> elem(t, 1) > elem(t, 0) end) |> Enum.count()
  end

  defp parseInput() do
    File.read!("day1_input.txt") |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.to_integer(x) end)
  end
end

IO.puts(Day1.part1())
IO.puts(Day1.part2())
