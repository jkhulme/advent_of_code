defmodule Day6 do
  def part1(input_path) do
    parseInput1(input_path) |> Enum.map(fn r -> computeStrategies(r, 1, 0) end) |> Enum.product
  end

  def part2(input_path) do
    parseInput2(input_path) |> computeStrategies(1, 0)
  end

  def computeStrategies({t, _}, t, n) do
    n
  end
  def computeStrategies({t, d}, hold, n) do
    if ((t - hold) * hold) > d do
      computeStrategies({t, d}, hold + 1, n + 1)
    else
      computeStrategies({t, d}, hold + 1, n)
    end
  end

  defp parseInput1(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line -> String.split(line, ": ") end)
      |> Enum.map(fn line -> Enum.at(line, 1) |> String.trim |> String.split(" ") |> Enum.reject(fn n -> n == "" end) |> Enum.map(fn n -> String.to_integer(n) end) end)
      |> Enum.zip
  end

  defp parseInput2(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line -> String.split(line, ": ") end)
      |> Enum.map(fn line -> Enum.at(line, 1) |> String.trim |> String.split(" ") |> Enum.reject(fn n -> n == "" end) |> Enum.join("") |> String.to_integer end)
      |> List.to_tuple
  end
end

IO.inspect(Day6.part1("day6_input.txt"))
IO.inspect(Day6.part2("day6_input.txt"))
