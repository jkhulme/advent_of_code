defmodule Day6 do
  def part1(input_path) do
    parseInput(input_path) |> findSignalStart(4)
  end

  def part2(input_path) do
    parseInput(input_path) |> findSignalStart(14)
  end

  defp findSignalStart(signal, packetLength) do
    Enum.to_list(0..packetLength - 1) |> Enum.map(fn i -> Enum.drop(signal, i) end) |> Enum.zip |> Enum.map(&Tuple.to_list/1) |> Enum.with_index(packetLength) |> Enum.find(fn {x, i} -> Enum.count(x) == Enum.count(Enum.uniq(x)) end) |> elem(1)
  end
 
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.codepoints
  end
end

IO.puts(Day6.part1("day6_input.txt"))
IO.puts(Day6.part2("day6_input.txt"))
