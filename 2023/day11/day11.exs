defmodule Day11 do
  def part1(input_path) do
    {input, dupY, dupX} = parseInput(input_path)
      Enum.reject(input, fn {n, _} -> n == "." end)
      |> galaxyDistances(dupY, dupX, [], 2)
      |> Enum.sum()
  end

  defp galaxyDistances([], _, _, distances, _) do
    distances
  end
  defp galaxyDistances([{_, {gX, gY}} | galaxies], dupY, dupX, distances, scale) do
    galaxyDistances(galaxies, dupY, dupX, distances ++ Enum.map(galaxies, fn {_, {x, y}} -> galaxyDistance({gX, gY}, {x, y}, dupY, dupX, scale) end), scale)
  end

  defp galaxyDistance({xA, yA}, {xB, yB}, dupY, dupX, scale) do
    overlapX = Enum.reject(dupX, fn x -> x < Enum.min([xA, xB]) or x > Enum.max([xA, xB]) end) |> Enum.count
    overlapY = Enum.reject(dupY, fn y -> y < Enum.min([yA, yB]) or y > Enum.max([yA, yB]) end) |> Enum.count
    (abs(xA - xB) - overlapX + (overlapX * scale)) + (abs(yA - yB) - overlapY + (overlapY * scale))
  end

  def part2(input_path) do
    {input, dupY, dupX} = parseInput(input_path)
      Enum.reject(input, fn {n, _} -> n == "." end)
      |> galaxyDistances(dupY, dupX, [], 1000000)
      |> Enum.sum()
  end

  defp parseInput(input_path) do
    input = File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.with_index
      |> Enum.map(fn {row, y} ->
        Enum.with_index(row) |> Enum.map(fn {n, x} -> {n, {x, y}} end)
      end)
    duplicateYs = Enum.reject(input, fn row -> Enum.any?(row, fn {n, _} -> n != "." end) end)
      |> Enum.map(fn row -> Enum.at(row, 0) |> elem(1) |> elem(1) end)
    duplicateXs = Enum.zip(input)
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.reject(fn row -> Enum.any?(row, fn {n, _} -> n != "." end) end)
      |> Enum.map(fn row -> Enum.at(row, 0) |> elem(1) |> elem(0) end)
    {Enum.flat_map(input, fn x -> x end), duplicateYs, duplicateXs}
  end
end

IO.inspect(Day11.part1("day11_input.txt"))
IO.inspect(Day11.part2("day11_input.txt"))
