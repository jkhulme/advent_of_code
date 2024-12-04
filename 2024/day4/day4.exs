defmodule Day4 do
  def part1(input_path) do
    matrix = parseInput(input_path)
    invert = Enum.zip(matrix) |> Enum.map(&Tuple.to_list/1)
    diagonalA = diagonals(matrix)
    diagonalB = Enum.map(matrix, &Enum.reverse/1) |> diagonals()

    Enum.map([matrix, invert, diagonalA, diagonalB], fn m -> countXmas(m, 0) end)
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
      |> Enum.map(fn row -> Enum.chunk_every(row, 3, 1, :discard) end)
      |> Enum.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.flat_map(&Enum.chunk_every(&1, 3, 1, :discard))
      |> countMas(0)
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
  end

  defp countXmas([], count) do
    count
  end
  defp countXmas([row | rows], count) do
    countXmas(
      rows,
      count +
        Enum.count(List.flatten(Regex.scan(~r/XMAS/, Enum.join(row, "")))) +
        Enum.count(List.flatten(Regex.scan(~r/SAMX/, Enum.join(row, ""))))
    )
  end

  defp countMas([], count) do
    count
  end
  defp countMas([m | ms], count) do
    case mas?(m) && mas?(Enum.reverse(m)) do
      true -> countMas(ms, count + 1)
      _ -> countMas(ms, count)
    end
  end

  defp mas?(m) do
    word = m |> Enum.with_index |> Enum.map(fn({row, index}) -> Enum.at(row, index) end) |> Enum.join("")
    word == "MAS" || word == "SAM"
  end

  def diagonals(matrix) do
    matrix
      |> Enum.with_index() # Attach row indices
      |> Enum.flat_map(fn {row, i} ->
        Enum.with_index(row) # Attach column indices
        |> Enum.map(fn {value, j} -> {i - j, value} end) # Compute diagonal key (i - j)
      end)
      |> Enum.group_by(fn {key, _value} -> key end, fn {_key, value} -> value end) # Group by diagonal key
      |> Enum.sort_by(fn {key, _values} -> key end) # Sort by diagonal key
      |> Enum.map(fn {_key, values} -> values end) # Extract grouped values
  end
end

IO.puts(Day4.part1("day4_input.txt"))
IO.puts(Day4.part2("day4_input.txt"))
