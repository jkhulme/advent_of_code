defmodule Day10 do
  def part1(input_path) do
    [topography, starts] = parseInput(input_path)
    starts
      |> Enum.map(fn s ->
        trail_score(s, topography)
          |> Enum.uniq
          |> Enum.count
      end)
      |> Enum.sum
  end

  def part2(input_path) do
    [topography, starts] = parseInput(input_path)
    starts
      |> Enum.map(fn s ->
        trail_score(s, topography)
          |> Enum.count
      end)
      |> Enum.sum
  end

  defp trail_score({{x, y}, 9}, _) do
    {{x, y}, 9}
  end
  defp trail_score({{x, y}, t}, topography) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
      |> Enum.map(fn k -> {k, Map.get(topography, k)} end)
      |> Enum.filter(fn {_, v} -> v == t + 1 end)
      |> Enum.map(&trail_score(&1, topography))
      |> List.flatten
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.with_index(
        fn row, y -> Enum.with_index(row, fn cell, x -> {{x, y}, cell} end) end
      )
      |> List.flatten
      |> build_topography(%{}, [])
  end

  defp build_topography([], topography, starts) do
    [topography, starts]
  end
  defp build_topography([{k, v} | points], topography, starts) do
    build_topography(
      points,
      Map.put(topography, k, String.to_integer(v)),
      case v do
        "0" -> [{k, 0} | starts]
        _ -> starts
      end
    )
  end
end

IO.puts(Day10.part1("day10_input.txt"))
IO.puts(Day10.part2("day10_input.txt"))
