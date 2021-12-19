defmodule Day8 do
  @moduledoc """
  Number of segments
  0: 6 : abcefg
  1: 2 : cf
  2: 5 : acdeg
  3: 5 : acdfg
  4: 4 : bcdf
  5: 5 : abdfg
  6: 6 : abdefg
  7: 3 : acf
  8: 7 : abcdefg
  9: 6 : abcdfg

  a: [0, 2, 3, 5, 6, 7, 8, 9]
  b: [0, 4, 5, 6, 8, 9]
  c: [0, 1, 2, 3, 4, 7, 8, 9]
  d: [0, 2, 3, 4, 5, 6, 8, 9]
  e: [0, 2, 6, 8]
  f: [0, 1, 3, 4, 5, 6, 7, 8, 9]
  g: [0, 2, 3, 4, 5, 6, 9, 9]
  """
  def part1(input_path) do
    input_path
      |> parseInput()
      |> Enum.map(fn [_, output] -> output end)
      |> List.flatten
      |> count_1478(0)
  end

  def part2(input_path) do
    patterns = input_path
      |> parseInput()
      |> Enum.map(fn [input, output] -> input ++ output end)
      |> Enum.map(fn patterns -> Enum.map(patterns, fn pattern -> String.graphemes(pattern) end) end)

    p = permutations(["a", "b", "c", "d", "e", "f", "g"]) |> Enum.map(fn perm -> Enum.zip(perm, ["a", "b", "c", "d", "e", "f", "g"]) |> Enum.into(%{}) end)
    Enum.map(patterns, fn pattern -> solve(p, pattern) |> Enum.map(fn s -> pattern_to_number(s) end) |> Enum.join("") |> String.to_integer end) |> Enum.sum
  end

  defp pattern_to_number(pattern) do
    case pattern  do
      ["a", "b", "c", "e", "f", "g"] ->
        "0"
      ["c", "f"] ->
        "1"
      ["a", "c", "d", "e", "g"] ->
        "2"
      ["a", "c", "d", "f", "g"] ->
        "3"
      ["b", "c", "d", "f"] ->
        "4"
      ["a", "b", "d", "f", "g"] ->
        "5"
      ["a", "b", "d", "e", "f", "g"] ->
        "6"
      ["a", "c", "f"] ->
        "7"
      ["a", "b", "c", "d", "e", "f", "g"] ->
        "8"
      ["a", "b", "c", "d", "f", "g"] ->
        "9"
      _ ->
        false
    end
  end

  defp solve([], x) do
    -1
  end
  defp solve([p | permutations], patterns) do
    case Enum.map(patterns, fn pattern -> valid_permutation(p, pattern) end) |> Enum.all? do
      true ->
        Enum.map(patterns, fn pattern -> translate(p, pattern) end) |> Enum.drop(10)
      false ->
        solve(permutations, patterns)
    end
  end

  defp valid_permutation(code, pattern) do
    case translate(code, pattern)  do
      ["a", "b", "c", "e", "f", "g"] ->
        true
      ["c", "f"] ->
        true
      ["a", "c", "d", "e", "g"] ->
        true
      ["a", "c", "d", "f", "g"] ->
        true
      ["b", "c", "d", "f"] ->
        true
      ["a", "b", "d", "f", "g"] ->
        true
      ["a", "b", "d", "e", "f", "g"] ->
        true
      ["a", "c", "f"] ->
        true
      ["a", "b", "c", "d", "e", "f", "g"] ->
        true
      ["a", "b", "c", "d", "f", "g"] ->
        true
      _ ->
        false
    end
  end

  def translate(code, pattern) do
    Enum.map(pattern, fn x -> Map.get(code, x) end) |> Enum.sort
  end

  def permutations([]) do
    [[]]
  end
  def permutations(list) do
    for h <- list, t <- permutations(list -- [h]), do: [h | t]
  end

  defp count_1478([], count) do
    count
  end
  defp count_1478([pattern|patterns], count) do
    case String.length(pattern) do
      l when l in [2, 3, 4, 7] ->
        count_1478(patterns, count + 1)
      _ ->
        count_1478(patterns, count)
    end
  end

  defp parseInput(path) do
    File.read!(path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn line -> String.split(line, " | ") end)
      |> Enum.map(fn [input, output] -> [String.split(input, " "), String.split(output, " ")] end)
  end
end

IO.puts(Day8.part1("day8_input.txt"))
IO.puts(Day8.part2("day8_input.txt"))
