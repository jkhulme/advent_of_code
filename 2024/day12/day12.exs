defmodule Day12 do
  def part1(input_path) do
    crop_map = parseInput(input_path)

    build_regions(crop_map, [])
      |> Enum.map(&calculate_price(&1, crop_map))
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
  end

  defp calculate_price(region, crop_map) do
    Enum.count(region) * perimeter(region, crop_map, 0)
  end

  defp perimeter([], _, acc) do
    acc
  end
  defp perimeter([{{x, y}, c} | crops], crop_map, acc) do
    p = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
      |> Enum.map(fn k -> Map.get(crop_map, k) end)
      |> Enum.reject(fn v -> v == c end)
      |> Enum.count
    perimeter(crops, crop_map, acc + p)
  end

  defp build_regions(map, regions) do
    cond do
      map == %{} ->
        regions
      true ->
        {x, y} = Map.keys(map) |> Enum.at(0)
        c = Map.get(map, {x, y})
        region = expand_region([{{x, y}, c}], map, [], %{}, c) |> Enum.uniq
        build_regions(remove_crop(region, map), [region | regions])
    end
  end

  defp remove_crop([], map) do
    map
  end
  defp remove_crop([{{x, c}, _} | crops], map) do
    remove_crop(crops, Map.delete(map, {x, c}))
  end

  defp expand_region([], _, region, _, _) do
    region
  end
  defp expand_region([{{x, y}, crop} | crops], crop_map, region, seen, crop) do
    candidates = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
      |> Enum.reject(fn k -> Map.get(seen, k) end)
      |> Enum.filter(fn k -> Map.get(crop_map, k) == crop end)

    expand_region(
      crops ++ Enum.map(candidates, fn k -> {k, crop} end),
      Map.drop(crop_map, candidates),
      [{{x, y}, crop} | region],
      Enum.into(Enum.map(candidates, fn k -> {k, crop} end), seen),
      crop
    )
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
      |> toMap(%{})
  end

  defp toMap([], map) do
    map
  end
  defp toMap([{k, v} | xs], map) do
    toMap(xs, Map.put(map, k, v))
  end
end

IO.puts(Day12.part1("day12_input.txt"))
# IO.puts(Day12.part2("day12_input.txt"))
