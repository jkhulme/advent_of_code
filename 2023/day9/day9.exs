defmodule Day9 do
  def part1(input_path) do
    parseInput(input_path) |> Enum.map(fn seq -> nextElement(seq) end) |> Enum.sum
  end

  def nextElement(seq) do
    newDeltas = delta(seq, [])
    if Enum.all?(newDeltas, &(&1 == 0)) do
      Enum.at(seq, -1) + 0
    else
      Enum.at(seq, -1) + nextElement(newDeltas)
    end
  end

  def prevElement(seq) do
    newDeltas = delta(seq, [])
    if Enum.all?(newDeltas, &(&1 == 0)) do
      Enum.at(seq, 0) - 0
    else
      Enum.at(seq, 0) - prevElement(newDeltas)
    end
  end

  def delta([x, y | sequence], out) do
    delta([y | sequence], out ++ [y - x])
  end
  def delta([_], out) do
    out
  end

  def part2(input_path) do
    parseInput(input_path) |> Enum.map(fn seq -> prevElement(seq) end) |> Enum.sum
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn seq -> Enum.map(seq, &String.to_integer/1) end)
  end
end

IO.inspect(Day9.part1("day9_input.txt"))
IO.inspect(Day9.part2("day9_input.txt"))
