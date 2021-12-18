defmodule Day3 do
  def part1(input_path) do
    input_path |> parseInput() |> Enum.zip() |> power_consumption([], [])
  end

  def part2(input_path) do
    readings = input_path |> parseInput()
    o2_rating(readings, 0) * co2_rating(readings, 0)
  end

  defp power_consumption([head | tail], gamma_rate, epsilon_rate) do
    if Enum.count(Tuple.to_list(head), fn x -> x == "1" end) >= Enum.count(Tuple.to_list(head), fn x -> x == "0" end) do
      power_consumption(tail, ["1" | gamma_rate], ["0" | epsilon_rate])
    else
      power_consumption(tail, ["0" | gamma_rate], ["1" | epsilon_rate])
    end
  end

  defp power_consumption([], gamma_rate, epsilon_rate) do
    base10_rate(gamma_rate) * base10_rate(epsilon_rate)
  end

  defp o2_rating([r|[]] = list, i) do
    r |> Enum.join("") |> String.to_integer(2)
  end

  defp o2_rating(readings, i) do
    ones = Enum.filter(readings, fn reading -> Enum.at(reading, i) == "1" end)
    zeroes = Enum.filter(readings, fn reading -> Enum.at(reading, i) == "0" end)
    if Enum.count(ones) >= Enum.count(zeroes) do
      o2_rating(ones, i + 1)
    else
      o2_rating(zeroes, i + 1)
    end
  end

  defp co2_rating([r|[]] = list, i) do
    r |> Enum.join("") |> String.to_integer(2)
  end

  defp co2_rating(readings, i) do
    ones = Enum.filter(readings, fn reading -> Enum.at(reading, i) == "1" end)
    zeroes = Enum.filter(readings, fn reading -> Enum.at(reading, i) == "0" end)
    if Enum.count(zeroes) <= Enum.count(ones) do
      co2_rating(zeroes, i + 1)
    else
      co2_rating(ones, i + 1)
    end
  end

  defp base10_rate(rate) do
    rate |> Enum.reverse() |> Enum.join("") |> String.to_integer(2)
  end

  defp parseInput(path) do
    File.read!(path) |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.graphemes(x) end)
  end
end

IO.puts(Day3.part1("day3_input.txt"))
IO.puts(Day3.part2("day3_input.txt"))
