defmodule Day7 do
  def part1(input_path) do
    input_path
      |> parseInput()
      |> calculateLinearFuel()
      |> Enum.min
  end

  def part2(input_path) do
    input_path
      |> parseInput()
      |> calculateNonLinearFuel()
      |> Enum.min
  end

  defp calculateLinearFuel(positions) do
    Enum.map(
      Enum.min(positions)..Enum.max(positions),
      fn goal ->
        Enum.map(positions, fn p -> abs(p - goal) end) |> Enum.sum
      end
    )
  end

  defp calculateNonLinearFuel(positions) do
    Enum.map(
      Enum.min(positions)..Enum.max(positions),
      fn goal ->
        Enum.map(positions, fn p -> Enum.sum(0..abs(p - goal)) end) |> Enum.sum
      end
    )
  end

  defp parseInput(path) do
    File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(fn x -> String.to_integer(x) end)
  end
end

IO.puts(Day7.part1("day7_input.txt"))
IO.puts(Day7.part2("day7_input.txt"))
