defmodule Search do
  def run(pos, map, seen, n_steps, dir, best) do
    cond do
      Map.get(map, pos) == "E" ->
        n_steps
      n_steps >= best ->
        best
      true ->
        cs = candidates(pos, map, seen)
        cs
          |> Enum.reduce(best, fn new_pos, current_best ->
            {cost, new_dir} = step_cost_and_next_direction(pos, new_pos, dir)

            new_best = run(new_pos, map, Map.put(seen, pos, true), n_steps + cost, new_dir, current_best)

            min(current_best, new_best)
          end)
    end
  end

  def candidates({x, y}, map, seen) do
    [{x - 1, y}, {x + 1, y}, {x, y + 1}, {x, y - 1}]
      |> Enum.reject(fn k -> Map.has_key?(seen, k) end)
      |> Enum.filter(fn k -> Enum.member?(["E", "."], Map.get(map, k)) end)
  end

  def step_cost_and_next_direction({x_current, y_current}, {x_new, y_new}, dir) do
    cond do
      # W
      {x_new, y_new} == {x_current - 1, y_current} ->
        case dir do
          "W" ->
            {1, "W"}
          _ ->
            {1001, "W"}
        end
      # E
      {x_new, y_new} == {x_current + 1, y_current} ->
        case dir do
          "E" ->
            {1, "E"}
          _ ->
            {1001, "E"}
        end
      # N
      {x_new, y_new} == {x_current, y_current - 1} ->
        case dir do
          "N" ->
            {1, "N"}
          _ ->
            {1001, "N"}
        end
      # S
      {x_new, y_new} == {x_current, y_current + 1} ->
        case dir do
          "S" ->
            {1, "S"}
          _ ->
            {1001, "S"}
        end
    end
  end
end

defmodule Day16 do
  def part1(input_path) do
    map = parseInput(input_path)
    start = Map.keys(map)
      |> starting_pos(map)

    Search.run(start, map, %{}, 0, "E", 1000000)
  end

  def part2(input_path) do
    parseInput(input_path)
  end

  defp starting_pos([], _) do
    raise("Could not find starting position")
  end
  defp starting_pos([k | keys], map) do
    case Map.get(map, k) do
      "S" ->
        k
      _ ->
        starting_pos(keys, map)
    end
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

IO.puts(Day16.part1("day16_input.txt"))
# IO.puts(Day16.part2("day16_input.txt"))
