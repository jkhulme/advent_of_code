defmodule Day1 do
  def part1(input_path) do
    parseInput(input_path) |> calibrate
  end

  def part2(input_path) do
    parseInput(input_path) |> Enum.map(fn c -> translateNumbers(c, numbers()) end) |> calibrate
  end

  defp parseInput(input_path) do
    File.read!(input_path) |> String.trim() |> String.split("\n")
  end

  defp translateNumbers(s, []) do
    s
  end
  defp translateNumbers(s, [{word, number} | ns]) do
    translateNumbers(String.replace(s, word, "#{word}#{number}#{word}"), ns)
  end

  defp numbers do
    [{"one", "1"}, {"two", "2"}, {"three", "3"}, {"four", "4"}, {"five", "5"}, {"six", "6"}, {"seven", "7"}, {"eight", "8"}, {"nine", "9"}]
  end

  defp calibrate(calibrations) do
    calibrations |> Enum.map(fn c -> String.replace(c, ~r/^\D*/, "") |> String.replace(~r/\D/, "") end) |> Enum.map(fn c -> "#{String.first(c)}#{String.last(c)}" |> String.to_integer end) |> Enum.sum()
  end
end

IO.puts(Day1.part1("day1_input.txt"))
IO.puts(Day1.part2("day1_input.txt"))
