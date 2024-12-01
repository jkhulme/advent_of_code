defmodule Day1 do
  def part1(input_path) do
    parseInput(input_path) 
      |> Enum.zip 
      |> Enum.map(fn ids -> Tuple.to_list(ids) |> Enum.sort end)
      |> Enum.zip
      |> distances
      |> Enum.sum
  end

  def part2(input_path) do
    [left, right] = parseInput(input_path)
      |> Enum.zip 
      |> Enum.map(fn ids -> Tuple.to_list(ids) |> Enum.sort end)
    similarity(left, counts(right, %{}))
      |> Enum.sum
  end

  defp parseInput(input_path) do
    File.read!(input_path) 
      |> String.trim() 
      |> String.split("\n") 
      |> Enum.map(fn l -> String.split(l) end)
      |> Enum.map(fn [a, b] -> [String.to_integer(a), String.to_integer(b)] end)
  end

  defp distances(ids) do
    ids |> Enum.map(fn {a, b} -> abs(a - b) end)
  end

  defp similarity(ids, countMap) do
    ids |> Enum.map(fn id -> id * Map.get(countMap, id, 0) end)
  end

  defp counts([], countMap) do
    countMap
  end
  defp counts([id | ids], countMap) do
    counts(
      ids, 
      Map.put(
        countMap,
        id,
        Map.get(countMap, id, 0) + 1
      )
    )
  end
end

IO.puts(Day1.part1("day1_input.txt"))
IO.puts(Day1.part2("day1_input.txt"))
