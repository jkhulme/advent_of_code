defmodule Mover do
  def moves([], map, _) do
    map
  end
  def moves([m | ms], map, pos) do
    # IO.inspect(m)
    {new_pos, updated_map} = move(m, map, pos)
    # Draw.print(updated_map)
    # IO.inspect("===============")
    moves(ms, updated_map, new_pos)
  end

  defp move("<", map, {x, y}) do
    _move(map, {x, y}, {x - 1, y}, Map.get(map, {x - 1, y}), "<")
  end
  defp move("^", map, {x, y}) do
    _move(map, {x, y}, {x, y - 1}, Map.get(map, {x, y - 1}), "^")
  end
  defp move(">", map, {x, y}) do
    _move(map, {x, y}, {x + 1, y}, Map.get(map, {x + 1, y}), ">")
  end
  defp move("v", map, {x, y}) do
    _move(map, {x, y}, {x, y + 1}, Map.get(map, {x, y + 1}), "v")
  end

  defp _move(map, pos, pos_new, elem, dir) do
    case elem do
      "#" ->
        {pos, map}
      "." ->
        {pos_new, Map.merge(map, %{pos => ".", pos_new => Map.get(map, pos)})}
      "O" ->
        {_, new_map } = move(dir, map, pos_new)
        cond do
          new_map == map ->
            {pos, new_map}
          true ->
            move(dir, new_map, pos)
        end
    end
  end
end

defmodule Draw do
  def print(map) do
    for y <- 0..7 do
      for x <- 0..7 do
        Map.get(map, {x, y})
      end
        |> Enum.join("")
    end
      |> Enum.map(&IO.inspect(&1))
  end
end

defmodule Day15 do
  def part1(input_path) do
    [map, moves] = parseInput(input_path)
    # IO.inspect("Initial")
    # Draw.print(map)
    # IO.inspect("===============")
    pos = starting_pos(Map.keys(map), map)

    final_positions = Mover.moves(moves, map, pos)
    Map.keys(final_positions)
      |> Enum.filter(fn k -> Map.get(final_positions, k) == "O" end)
      |> Enum.map(fn {x, y} -> 100 * y + x end)
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
  end

  defp starting_pos([], _) do
    raise("Could not find starting position")
  end
  defp starting_pos([k | keys], map) do
    case Map.get(map, k) do
      "@" ->
        k
      _ ->
        starting_pos(keys, map)
    end
  end

  defp parseInput(input_path) do
    [map, moves] = File.read!(input_path)
      |> String.trim()
      |> String.split("\n\n")

    x = String.split(map, "\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.with_index(
        fn row, y -> Enum.with_index(row, fn cell, x -> {{x, y}, cell} end) end
      )
      |> List.flatten
      |> toMap(%{})

    [x, String.graphemes(String.replace(moves, "\n", ""))]
  end

  defp toMap([], map) do
    map
  end
  defp toMap([{k, v} | xs], map) do
    toMap(xs, Map.put(map, k, v))
  end
end

IO.puts(Day15.part1("day15_input.txt"))
# IO.puts(Day15.part2("day15_input.txt"))
