defmodule Day4 do
  def part1(input_path) do
    parseInput(input_path) |> countTotalOverlap
  end

  def part2(input_path) do
    parseInput(input_path) |> countPartialOverlap
  end

  defp countTotalOverlap([[[a, b], [x, y]] | remainingPairs]) 
    when a <= x and b >= y
    when x <= a and y >= b do
      1 + countTotalOverlap(remainingPairs)
  end
  defp countTotalOverlap([_ | remainingPairs ]) do
    0 + countTotalOverlap(remainingPairs)
  end
  defp countTotalOverlap([]) do
    0
  end

  defp countPartialOverlap([[[a, b], [x, y]] | remainingPairs]) 
    when a >= x and a <= y
    when x >= a and x <= b
    when b >= x and b <= y
    when y >= a and y <= b do
      1 + countPartialOverlap(remainingPairs)
  end
  defp countPartialOverlap([_ | remainingPairs ]) do
    0 + countPartialOverlap(remainingPairs)
  end
  defp countPartialOverlap([]) do
    0
  end
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.trim(x) |> String.split(",") end) |> Enum.map(fn x -> Enum.map(x, fn y -> String.split(y, "-") |> Enum.map(fn z -> String.to_integer(z) end) end) end)
  end
end

IO.puts(Day4.part1("day4_input.txt"))
IO.puts(Day4.part2("day4_input.txt"))
