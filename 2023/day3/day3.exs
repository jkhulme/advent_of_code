defmodule Day3 do
  def part1(input_path) do
    schematic = parseInput(input_path)
    symbolMap = Enum.reject(schematic, fn {_, s} -> String.match?(s, ~r/\d/) end) |> Enum.flat_map(fn {c, _} -> c end) |> Map.new(fn {x, y} -> {{x, y}, true } end)
    Enum.reject(schematic, fn {_, s} -> !String.match?(s, ~r/\d/) end) |> Enum.reject(fn {coords, _} -> !neighboursPart?(coords, symbolMap) end)
      |> Enum.map(fn {_, n} -> String.to_integer(n) end) |> Enum.sum
  end

  defp neighboursPart?(coords, symbolMap) do
    Enum.flat_map(coords, fn coord -> neighbourCoords(coord) end) |> Enum.uniq |> Enum.any?(fn coord -> Map.has_key?(symbolMap, coord) end)
  end

  defp neighbourCoords({x, y}) do
    [{x - 1, y - 1}, {x, y - 1}, {x + 1, y - 1}, {x - 1, y}, {x, y}, {x + 1, y}, {x - 1, y + 1}, {x, y + 1}, {x + 1, y + 1}]
  end

  def part2(input_path) do
    schematic = parseInput(input_path)
    gears = Enum.reject(schematic, fn {_, s} -> s != "*" end) |> Enum.flat_map(fn {c, _} -> c end)
    numbers = Enum.reject(schematic, fn {_, s} -> !String.match?(s, ~r/\d/) end)

    Enum.map(gears, fn gear -> gearParts(gear, numbers) end)
      |> Enum.reject(fn ps -> Enum.count(ps) != 2 end)
      |> Enum.map(fn ps -> Enum.map(ps, fn {_, n} -> String.to_integer(n) end) |> Enum.product end) |> Enum.sum
  end

  defp gearParts(gear, parts) do
    Enum.reject(parts, fn {coords, _} ->
      MapSet.size(MapSet.intersection(MapSet.new(coords), MapSet.new(neighbourCoords(gear)))) == 0
    end)
  end

  defp mergeNumbers(list) do
    chunk_fun = fn
      elem, [] -> {:cont, [elem]}
      {{x1, y1}, n1}, [{{x2, _}, n2} | _] = acc when x2 + 1 == x1
        and (n1 == "1" or n1 == "2" or n1 == "3" or n1 == "4" or n1 == "5" or n1 == "6" or n1 == "7" or n1 == "8" or n1 == "9" or n1 == "0")
        and (n2 == "1" or n2 == "2" or n2 == "3" or n2 == "4" or n2 == "5" or n2 == "6" or n2 == "7" or n2 == "8" or n2 == "9" or n2 == "0") -> {:cont, [{{x1, y1}, n1} | acc]}
      elem, acc -> {:cont, Enum.reverse(acc), [elem]}
    end
    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end
    Enum.chunk_while(list, [], chunk_fun, after_fun)
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn l -> String.graphemes(l) |> Enum.with_index |> Enum.reject(fn {x, _} -> x == "." end) end)
      |> Enum.with_index
      |> Enum.map(fn {line, y} -> Enum.map(line, fn {l, x} -> {{x, y}, l} end) end)
      |> Enum.map(fn line -> mergeNumbers(line) end)
      |> Enum.flat_map(fn line -> Enum.map(line, fn x -> Enum.reduce(x, {[], ""}, fn {c, p}, {cAcc, pAcc} -> {Enum.concat(cAcc, [c]), "#{pAcc}#{p}"} end) end) end)
  end
end

IO.inspect(Day3.part1("day3_input.txt"))
IO.inspect(Day3.part2("day3_input.txt"))
