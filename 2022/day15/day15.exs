defmodule Day15 do
  def part1(input_path) do
    locations = parseInput(input_path)
    {sensors, beacons} = separate(locations, [], [])
    minX = Enum.map([sensors, beacons], fn cs -> Enum.min_by(cs, fn {x, _} -> x end) end) |> Enum.min |> elem(0)
    maxX = Enum.map([sensors, beacons], fn cs -> Enum.max_by(cs, fn {x, _} -> x end) end) |> Enum.max |> elem(0)
    minY = Enum.map([sensors, beacons], fn cs -> Enum.min_by(cs, fn {_, y} -> y end) end) |> Enum.min |> elem(1)
    maxY = Enum.map([sensors, beacons], fn cs -> Enum.max_by(cs, fn {_, y} -> y end) end) |> Enum.max |> elem(1)

    grid = Enum.to_list(minY..maxY) |> Enum.map(fn y -> Enum.map(Enum.to_list(minX..maxX), fn x -> {x, y} end) end)

    closest = Enum.map(locations, fn [s, b] -> { s, distance(s, b) } end)

    state = checkGrid(%{}, sensors, beacons, closest, grid)

    print(grid, state)

    Enum.map(Enum.at(grid, 10 + minY), fn cell -> state[cell] end) |> Enum.filter(fn x -> x == "#" end) |> Enum.count
  end

  def part2(input_path) do
    parseInput(input_path)
  end

  defp print([], _) do
    IO.puts("\n")
  end
  defp print([row | rows], state) do
    row |> Enum.map(fn x -> Map.get(state, x, ".") end) |> Enum.join("") |> IO.puts
    print(rows, state)
  end

  defp checkGrid(state, _, _, _, []) do
    state
  end
  defp checkGrid(state, sensors, beacons, closest, [row | rows]) do
    checkRow(state, sensors, beacons, closest, row) |> checkGrid(sensors, beacons, closest, rows)
  end

  defp checkRow(state, _, _, _, []) do
    state
  end
  defp checkRow(state, sensors, beacons, closest, [cell | cells]) do
    cond do
      Enum.member?(beacons, cell) ->
        Map.put(state, cell, "B") |> checkRow(sensors, beacons, closest, cells)
      Enum.member?(sensors, cell) ->
        Map.put(state, cell, "S") |> checkRow(sensors, beacons, closest, cells)
      Enum.map(closest, fn {p, d} -> distance(cell, p) <= d end) |> Enum.any? ->
        Map.put(state, cell, "#") |> checkRow(sensors, beacons, closest, cells)
      true ->
        checkRow(state, sensors, beacons, closest, cells)
    end
  end

  defp separate([], ss, bs) do
    {ss, bs}
  end
  defp separate([[s, b] | sbs], ss, bs) do
    separate(sbs, [s | ss], [b | bs])
  end

  defp distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  defp parseInput(input_path) do
    File.read!(input_path) |>
      String.trim |>
      String.split("\n") |>
      Enum.map(&String.split(&1, ": ") |> Enum.map(fn x -> String.split(x, "x=") |> Enum.at(1) |> String.split(", y=") |> Enum.map(fn x -> String.to_integer(x) end) |> Enum.to_list |> List.to_tuple end))
  end
end

# IO.puts(Day15.part1("day15_input.txt"))
# IO.puts(Day15.part2("day15_input.txt"))
