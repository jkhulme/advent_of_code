defmodule Day5 do
  def part1(input_path) do
    input_path
      |> parseInput()
      |> Enum.map(fn points -> interpolate_straight(points) end)
      |> count_overlap
  end

  def part2(input_path) do
    input_path
      |> parseInput()
      |> Enum.map(fn points -> interpolate_all(points) end)
      |> count_overlap
  end

  def count_overlap(points) do
    points
      |> List.flatten
      |> Enum.frequencies
      |> Map.to_list
      |> Enum.filter(fn {points, count} -> count > 1 end)
      |> Enum.count
  end

  def interpolate_straight(points) do
    case points do
      [{a, y}, {b, y}] ->
        Enum.zip(Enum.to_list(a..b), List.duplicate(y, abs(b - a) + 1))
      [{x, a}, {x, b}] ->
        Enum.zip(List.duplicate(x, abs(b - a) + 1), Enum.to_list(a..b))
      _ ->
        []
    end
  end

  def interpolate_all(points) do
    case points do
      [{a, y}, {b, y}] ->
        Enum.zip(Enum.to_list(a..b), List.duplicate(y, abs(b - a) + 1))
      [{x, a}, {x, b}] ->
        Enum.zip(List.duplicate(x, abs(b - a) + 1), Enum.to_list(a..b))
      [{a, b}, {c, d}] ->
        Enum.zip(Enum.to_list(a..c), Enum.to_list(b..d))
    end
  end

  defp parseInput(path) do
    File.read!(path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, " -> ") |> Enum.map(fn points -> String.split(points, ",") |> Enum.map(fn i -> String.to_integer(i) end) |> List.to_tuple  end) end)
  end
end

IO.puts(Day5.part1("day5_input.txt"))
IO.puts(Day5.part2("day5_input.txt"))
