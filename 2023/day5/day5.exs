defmodule Day5 do
  def part1(input_path) do
    {seeds, order, maps} = parseInput(input_path)
    Enum.map(seeds, fn seed -> findLocation(order, maps, seed) end) |> Enum.min
  end

  defp findLocation([], _, seed) do
    seed
  end
  defp findLocation([label | labels], maps, seed) do
    newLocation = Map.get(maps, label) |> Enum.find({seed, seed, 0}, fn {_, s, r} -> seed >= s and seed <= s + r end)
      |> then(fn {d, s, _} -> d + (seed - s) end)
    findLocation(labels, maps, newLocation)
  end

  def part2(input_path) do
    {seeds, order, maps} = parseInput(input_path)
    plantSeeds(
      order,
      maps,
      Enum.chunk_every(seeds, 2) |> Enum.map(fn [i, j] -> {i, i + j - 1} end)
    ) |> Enum.map(fn {i, _} -> i end) |> Enum.min
  end

  defp plantSeeds([], _, seeds) do
    seeds
  end
  defp plantSeeds([l | locations], maps, seeds) do
    plantSeeds(
      locations,
      maps,
      Enum.flat_map(
        seeds,
        fn seed -> applyRules(Map.get(maps, l) |> Enum.sort_by(&(elem(&1, 1))), [], seed, seed) end
      )
    )
  end

  defp applyRules([], [], seedPair, _) do
    [seedPair]
  end
  defp applyRules([], updatedSeedPairs, _, _) do
    updatedSeedPairs |> Enum.uniq
  end
  defp applyRules([{d, s, r} | rules], updatedSeedPairs, {sL, sU}, original) do
    cond do
      sU < s ->
        applyRules(rules, updatedSeedPairs, { sL, sU }, original)
      sL > s + r - 1 ->
        applyRules(rules, updatedSeedPairs, { sL, sU }, original)
      sL < s ->
        applyRules(rules, applyRules(rules, [], {sL, s - 1}, {sL, s - 1}) ++ updatedSeedPairs, { s, sU }, original)
      sU > s + r - 1 ->
        applyRules([{d, s, r} | rules], applyRules(rules, [], {s + r, sU}, {s + r, sU}) ++ updatedSeedPairs, { sL, s + r - 1 }, original)
      true ->
        applyRules([], [{sL + d - s, sU + d - s} | updatedSeedPairs], original, original)
    end
  end

  defp parseInput(input_path) do
    input = File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.chunk_by(fn x -> x == "" end)
    seeds = Enum.at(input, 0) |> Enum.at(0) |> String.split(": ") |> Enum.at(1) |> String.split(" ") |> Enum.map(fn x -> String.to_integer(x) end)
    maps = Enum.drop(input, 1)
      |> Enum.reject(fn map -> map == [""] end)
      |> Enum.map(fn [label | data] -> String.split(label, " map:")
        |> Enum.at(0)
        |> then(fn l -> Map.put(
          %{},
          l,
          Enum.map(data, fn d -> String.split(d, " ") |> Enum.map(fn n -> String.to_integer(n) end) |> List.to_tuple end)
        ) end)
      end)
      |> mergeMap(%{})
    order = ["seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water", "water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"]
    {seeds, order, maps}
  end

  defp mergeMap([], map) do
    map
  end
  defp mergeMap([m | maps], map) do
    mergeMap(maps, Map.merge(map, m))
  end
end

IO.inspect(Day5.part1("day5_input.txt"))
IO.inspect(Day5.part2("day5_input.txt"))
