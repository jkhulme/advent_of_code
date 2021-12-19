defmodule Day6 do
  def part1(input_path) do
    input_path
      |> parseInput()
      |> initial_counts(List.duplicate(0, 9))
      |> generations(80)
      |> Enum.sum
  end

  def part2(input_path) do
    input_path
      |> parseInput()
      |> initial_counts(List.duplicate(0, 9))
      |> generations(256)
      |> Enum.sum
  end

  defp initial_counts([], counts) do
    counts
  end
  defp initial_counts([f | fish], counts) do
    initial_counts(fish, List.update_at(counts, f, &(&1 + 1)))
  end

  defp generations(counts, 0) do
    counts
  end
  defp generations([c | counts], i) do
    generations(List.update_at(counts ++ [c], 6, &(&1 + c)), i - 1)
  end

  defp parseInput(path) do
    File.read!(path)
      |> String.trim()
      |> String.split(",")
      |> Enum.map(fn x -> String.to_integer(x) end)
  end
end

IO.puts(Day6.part1("day6_input.txt"))
IO.puts(Day6.part2("day6_input.txt"))
