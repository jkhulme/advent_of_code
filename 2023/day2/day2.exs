defmodule Day2 do
  def part1(input_path) do
    parseInput(input_path) |> Enum.reject(fn {_, game} -> !legal?(game) end) |> Enum.map(fn {id, _} -> id end) |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path) |> Enum.map(fn {id, game} -> minimumBalls(game, %{}) |> Map.values |> Enum.product end) |> Enum.sum
  end

  defp minimumBalls([], balls) do
    balls
  end
  defp minimumBalls([s | sets], balls) do
    minimumBalls(sets, Map.merge(s, balls, fn _, v1, v2 -> Enum.max([v1, v2]) end))
  end

  defp legal?(sets) do
    Enum.all?(sets, fn set -> Map.get(set, "blue", 0) <= 14 and Map.get(set, "green", 0) <= 13 and Map.get(set, "red", 0) <= 12 end)
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn g -> String.split(g, ":") end)
      |> Enum.map(fn [a, b] ->
        {
          String.split(a, "Game ") |> Enum.at(1) |> String.to_integer,
          String.split(b, ";") |>
            Enum.map(
              fn sets -> String.split(sets, ",")
                |> Enum.map(fn set -> String.trim(set) |> String.split(" ") end)
                |> Enum.map(fn [n, c] -> {c, String.to_integer(n)} end) |> Map.new
            end)}
      end)
  end
end

IO.inspect(Day2.part1("day2_input.txt"))
IO.inspect(Day2.part2("day2_input.txt"))
