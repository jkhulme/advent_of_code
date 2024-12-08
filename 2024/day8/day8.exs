defmodule Line do
  def points_outside_segment({x1, y1}, {x2, y2}, {max_x, max_y}) do
    dx = x2 - x1
    dy = y2 - y1

    forward_points = generate_line_points(x2, y2, dx, dy, {0, max_x, 0, max_y})
    backward_points = generate_line_points(x1, y1, -dx, -dy, {0, max_x, 0, max_y})

    Enum.reverse(backward_points) ++ forward_points
  end

  defp generate_line_points(x, y, dx, dy, {min_x, max_x, min_y, max_y}, acc \\ []) do
    new_x = x + dx
    new_y = y + dy

    if in_bounds?(new_x, new_y, {min_x, max_x, min_y, max_y}) do
      generate_line_points(new_x, new_y, dx, dy, {min_x, max_x, min_y, max_y}, [{new_x, new_y} | acc])
    else
      acc
    end
  end

  defp in_bounds?(x, y, {min_x, max_x, min_y, max_y}) do
    x >= min_x and x <= max_x and y >= min_y and y <= max_y
  end
end

defmodule Day8 do
  def part1(input_path) do
    [locations, limits] = parseInput(input_path)
    Map.keys(locations)
      |> Enum.flat_map(&antinodes(Map.get(locations, &1), limits))
      |> Enum.uniq
      |> Enum.count
  end

  def part2(input_path) do
    [locations, limits] = parseInput(input_path)
    Map.keys(locations)
      |> Enum.flat_map(&antinodesP2(Map.get(locations, &1), limits))
      |> Enum.uniq
      |> Enum.count
  end

  defp antinodes(locations, limits) do
    location_pairs(locations, [])
      |> Enum.flat_map(&find_antinodes(&1, limits))
  end

  defp antinodesP2(locations, limits) do
    location_pairs(locations, [])
      |> Enum.flat_map(&find_antinodesP2(&1, limits))
  end

  defp find_antinodes({{a_x, a_y}, {b_x, b_y}}, limits) do
    Line.points_outside_segment({a_x, a_y}, {b_x, b_y}, limits)
      |> Enum.filter(fn {x, y} ->
        abs(a_x - x) == 2 * abs(b_x - x) && abs(a_y - y) == 2 * abs(b_y - y)
          || 2 * abs(a_x - x) == abs(b_x - x) && 2 * abs(a_y - y) == abs(b_y - y)
      end)
  end

  defp find_antinodesP2({{a_x, a_y}, {b_x, b_y}}, limits) do
    [{a_x, a_y}, {b_x, b_y}] ++ Line.points_outside_segment({a_x, a_y}, {b_x, b_y}, limits)
  end

  defp location_pairs([_ | []], pairs) do
    pairs
  end
  defp location_pairs([x | locations], pairs) do
    x_pairs = for y <- locations, do: {x, y}
    location_pairs(locations, x_pairs ++ pairs)
  end

  defp parseInput(input_path) do
    map = File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.with_index(
        fn row, y -> Enum.with_index(row, fn cell, x -> {{x, y}, cell} end) end
      )
    limits = {Enum.count(Enum.at(map, 0)) - 1, Enum.count(map) - 1}

    antennae = map
      |> List.flatten
      |> Enum.reject(fn {_, cell} -> cell == "." end)

    [buildMap(antennae, %{}), limits]
  end

  defp buildMap([], map) do
    map
  end
  defp buildMap([{pos, antenna} | as], map) do
    buildMap(
      as,
      Map.update(map, antenna, [pos], fn positions -> [pos | positions] end)
    )
  end
end

IO.puts(Day8.part1("day8_input.txt"))
IO.puts(Day8.part2("day8_input.txt"))
