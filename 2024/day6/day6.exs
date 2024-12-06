defmodule Day6 do
  def part1(input_path) do
    {guard_pos, cols, rows, limit} = parseInput(input_path)
    walk({guard_pos, cols, rows, limit}, [{guard_pos, "N"}], "N")
      |> Enum.map(&elem(&1, 0))
      |> Enum.uniq
      |> Enum.count
  end

  def part2(input_path) do
    {guard_pos, cols, rows, limit} = parseInput(input_path)
    c = walk({guard_pos, cols, rows, limit}, [{guard_pos, "N"}], "N")
      |> Enum.uniq
      |> insertLoop({guard_pos, cols, rows, limit}, [])
      |> Enum.map(&elem(&1, 0))
      |> Enum.uniq
      |> Enum.count
    # Subtract one because it picks up the starting point as a loop obstacle, which it is not
    c - 1
  end

  defp insertLoop([], _, loopSpots) do
    loopSpots
  end
  defp insertLoop([{p, d} | path], { guard_pos, cols, rows, limit }, loop_spots) do
    case p do
      {4, 6} -> insertLoop(path, { guard_pos, cols, rows, limit}, loop_spots)
      _ ->
        {_, uCols, uRows} = buildMap([{p, "#"}], cols, rows, guard_pos)
        steps = walk({guard_pos, uCols, uRows, limit}, [{guard_pos, "N"}], "N")
        case steps do
          [] -> insertLoop(path, { guard_pos, cols, rows, limit}, [{p, d} | loop_spots])
          _ -> insertLoop(path, { guard_pos, cols, rows, limit}, loop_spots)
        end
    end
  end

  defp walk({{guard_x, guard_y}, cols, rows, limit}, steps, dir) do
    case dir do
      "N" ->
        {_, block_y} = { guard_x, Enum.find(Enum.reverse(Map.get(cols, guard_x, [])), fn y -> y < guard_y end) }
        if Enum.count(steps, fn s -> s == {{guard_x, guard_y}, "W"} end) > 1 do
          []
        else
          if block_y do
            walk(
              {
                {guard_x, block_y + 1},
                cols,
                rows,
                limit
              },
              steps ++ Enum.reverse(Enum.map(((block_y + 1)..(guard_y - 1)), fn y -> {{guard_x, y}, dir} end)),
              "E"
            )
          else
            steps ++ Enum.reverse(Enum.map(((0)..(guard_y - 1)), fn y -> {{guard_x, y}, dir} end))
          end
        end
      "E" ->
        {block_x, _} = { Enum.find(Map.get(rows, guard_y, []), fn x -> x > guard_x end), guard_y }
        if Enum.count(steps, fn s -> s == {{guard_x, guard_y}, "N"} end) > 1 do
          []
        else
          if block_x do
            walk(
              {
                {block_x - 1, guard_y},
                cols,
                rows,
                limit
              },
              steps ++ Enum.map(((guard_x + 1)..(block_x - 1)), fn x -> {{x, guard_y}, dir} end),
              "S"
            )
          else
            steps ++ Enum.map(((guard_x + 1)..elem(limit, 0)), fn x -> {{x, guard_y}, dir} end)
          end
        end
      "S" ->
        {_, block_y} = { guard_x, Enum.find(Map.get(cols, guard_x, []), fn y -> y > guard_y end) }
        if Enum.count(steps, fn s -> s == {{guard_x, guard_y}, "E"} end) > 1 do
          []
        else
          if block_y do
            walk(
              {
                {guard_x, block_y - 1},
                cols,
                rows,
                limit
              },
              steps ++ Enum.map(((guard_y + 1)..(block_y - 1)), fn y -> {{guard_x, y}, dir} end),
              "W"
            )
          else
            steps ++ Enum.map(((guard_y + 1)..elem(limit, 1)), fn y -> {{guard_x, y}, dir} end)
          end
        end
      _ ->
        {block_x, _} = { Enum.find(Enum.reverse(Map.get(rows, guard_y, [])), fn x -> x < guard_x end), guard_y }
        if Enum.count(steps, fn s -> s == {{guard_x, guard_y}, "S"} end) > 1 do
          []
        else
          if block_x do
            walk(
              {
                {block_x + 1, guard_y},
                cols,
                rows,
                limit
              },
              steps ++ Enum.reverse(Enum.map(((block_x + 1)..(guard_x - 1)), fn x -> {{x, guard_y}, dir} end)),
              "N"
            )
          else
            steps ++ Enum.reverse(Enum.map((0..(guard_x - 1)), fn x -> {{x, guard_y}, dir} end))
          end
        end
    end
  end

  defp parseInput(input_path) do
    cells = File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.with_index(
        fn row, y -> Enum.with_index(row, fn cell, x -> {{x, y}, cell} end) end
      )

    {guard_pos, cols, rows} = List.flatten(cells)
      |> buildMap(%{}, %{}, {})

    {guard_pos, cols, rows, { Enum.count(cells) - 1, Enum.count(Enum.at(cells, 0)) - 1 }}
  end

  defp buildMap([], cols, rows, guard_pos) do
    {guard_pos, cols, rows}
  end
  defp buildMap([{{x, y}, cell} | cells], cols, rows, guard_pos) do
    case cell do
      "." ->
        buildMap(cells, cols, rows, guard_pos)
      "^" ->
        buildMap(cells, cols, rows, {x, y})
      _ ->
        buildMap(
          cells,
          Map.update(cols, x, [y], fn existing -> Enum.sort([y | existing]) end),
          Map.update(rows, y, [x], fn existing -> Enum.sort([x | existing]) end),
          guard_pos
        )
    end
  end
end

IO.puts(Day6.part1("day6_input.txt"))
IO.puts(Day6.part2("day6_input.txt"))
