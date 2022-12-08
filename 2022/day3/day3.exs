defmodule Day3 do
  def part1(input_path) do
    parseInput(input_path) |> Enum.map(fn x -> Enum.split(x, div(Enum.count(x), 2)) end) |> Enum.map(fn {x, y} -> commonItem(x, y) end) |> List.flatten |> List.to_charlist |> score
  end

  def part2(input_path) do
    parseInput(input_path) |> Enum.chunk_every(3) |> Enum.map(fn [x, y, z] -> commonItem(x, y, z) end) |> List.flatten |> List.to_charlist |> score
  end

  defp commonItem(c1, c2) do
    c1 -- (c1 -- c2) |> Enum.dedup
  end
  defp commonItem(c1, c2, c3) do
    commonItem(commonItem(c1, c2), commonItem(c2, c3))
  end

  defp score([l | ls]) when l >= 97, do: 1 + l - ?a + score(ls)
  defp score([l | ls]) when l >= 65, do: 27 + l - ?A + score(ls)
  defp score([]) do
    0
  end
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.trim(x) |> String.codepoints() end)
  end
end

IO.puts(Day3.part1("day3_input.txt"))
IO.puts(Day3.part2("day3_input.txt"))
