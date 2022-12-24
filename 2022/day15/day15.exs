defmodule Day15 do
  def part1(input_path, gY) do
    locations = parseInput(input_path)
    {sensors, beacons} = separate(locations, [], [])
    closest = Enum.map(locations, fn [s, b] -> { s, distance(s, b) } end)
    maxRange = Enum.max_by(closest, fn {_, d} -> d end) |> elem(1)

    minX = (Enum.map([sensors, beacons], fn cs -> Enum.min_by(cs, fn {x, _} -> x end) end) |> Enum.min |> elem(0)) - maxRange
    maxX = (Enum.map([sensors, beacons], fn cs -> Enum.max_by(cs, fn {x, _} -> x end) end) |> Enum.max |> elem(0)) + maxRange
    row = Enum.map(Enum.to_list(minX..maxX), fn x -> {x, gY} end)

    checkRow(row, sensors, beacons, closest)
  end

  def part2(input_path, maxXY) do
    locations = parseInput(input_path)
    {sensors, beacons} = separate(locations, [], [])
    closest = Enum.map(locations, fn [s, b] -> { s, distance(s, b) } end)
    maxRange = Enum.max_by(closest, fn {_, d} -> d end) |> elem(1)

    maxX = [(Enum.map([sensors, beacons], fn cs -> Enum.max_by(cs, fn {x, _} -> x end) end) |> Enum.max |> elem(0)) + maxRange, maxXY] |> Enum.min
    maxY = [(Enum.map([sensors, beacons], fn cs -> Enum.max_by(cs, fn {y, _} -> y end) end) |> Enum.max |> elem(1)) + maxRange, maxXY] |> Enum.min

    dY = locateDistressBeacon(maxY, maxX, sensors, beacons, closest)
    dX = Enum.map(Enum.to_list(0..maxX), fn x -> beacon?({x, dY}, sensors, beacons, closest) end) |> Enum.find_index(fn c -> c == true end)

    (4000000 * dX) + dY
  end

  defp locateDistressBeacon(-1, _, _, _, _) do
    -1
  end
  defp locateDistressBeacon(y, maxX, sensors, beacons, closest) do
    beaconCandidates = Enum.map(Enum.to_list(0..maxX), fn x -> {x, y} end) |> Enum.count(&beacon?(&1, sensors, beacons, closest))
    cond do
      beaconCandidates == 1 ->
        y
      true ->
        locateDistressBeacon(y - 1, maxX, sensors, beacons, closest)
    end
  end

  defp checkRow(row, sensors, beacons, closest) do
    row |> Enum.count(&beaconFree?(&1, sensors, beacons, closest))
  end

  defp beacon?(cell, sensors, beacons, closest) do
    cond do
      Enum.member?(beacons, cell) ->
        false
      Enum.member?(sensors, cell) ->
        false
      Enum.map(closest, fn {s, d} -> distance(s, cell) <= d end) |> Enum.any? ->
        false
      true ->
        true
    end
  end

  defp beaconFree?(cell, _, beacons, closest) do
    cond do
      Enum.member?(beacons, cell) ->
        false
      # Enum.member?(sensors, cell) ->
      #   false
      Enum.map(closest, fn {s, d} -> distance(s, cell) <= d end) |> Enum.any? ->
        true
      true ->
        false
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

# IO.puts(Day15.part1("day15_input.txt", 2000000))
IO.puts(Day15.part2("day15_input.txt", 4000000))
