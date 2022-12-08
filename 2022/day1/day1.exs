defmodule Day1 do
  def part1(input_path) do
    parseInput(input_path) |> Enum.max
  end

  def part2(input_path) do
    parseInput(input_path) |> Enum.sort |> Enum.take(-3) |> Enum.sum()
  end
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.trim(x) end) |> Enum.chunk_by(&(&1 == "")) |> Enum.take_every(2) |> Enum.map(fn xs -> Enum.map(xs, fn x -> String.to_integer(x) end) |> Enum.sum() end)
  end
end

IO.puts(Day1.part1("day1_input.txt"))
IO.puts(Day1.part2("day1_input.txt"))
