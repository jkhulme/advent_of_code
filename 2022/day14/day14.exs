defmodule Day14 do
  def part1(input_path) do
    IO.puts("Part 1\n")
    rockLines = parseInput(input_path) |> Enum.map(fn x -> Enum.zip(x, Enum.drop(x, 1)) |> fill end)
    area = [{500, 0} | List.flatten(rockLines)]
    [minX, maxX] = [Enum.min_by(area, fn {x, _} -> x end) |> elem(0), Enum.max_by(area, fn {x, _} -> x end) |> elem(0)]
    [minY, maxY] = [Enum.min_by(area, fn {_, y} -> y end) |> elem(1), Enum.max_by(area, fn {_, y} -> y end) |> elem(1)]
    grid = Enum.to_list(minY..maxY) |> Enum.map(fn y -> Enum.map(Enum.to_list(minX..maxX), fn x -> {x, y} end) end)
    state = Map.update!(buildState(%{}, grid, List.flatten(rockLines), nil), {500, 0}, fn _ -> "+" end)
    state = placeSandPart1(state, {500, 0})
    print(grid, state)
    Map.values(state) |> Enum.filter(fn x -> x == "o" end) |> Enum.count
  end

  def part2(input_path) do
    IO.puts("Part 2\n")
    rockLines = parseInput(input_path) |> Enum.map(fn x -> Enum.zip(x, Enum.drop(x, 1)) |> fill end)
    area = [{500, 0} | List.flatten(rockLines)]
    [minX, maxX] = [Enum.min_by(area, fn {x, _} -> x end) |> elem(0), Enum.max_by(area, fn {x, _} -> x end) |> elem(0)]
    [minY, maxY] = [Enum.min_by(area, fn {_, y} -> y end) |> elem(1), Enum.max_by(area, fn {_, y} -> y end) |> elem(1)]
    grid = Enum.to_list(minY..maxY) |> Enum.map(fn y -> Enum.map(Enum.to_list(minX..maxX), fn x -> {x, y} end) end)

    floor = maxY + 2
    grid = grid ++ [Enum.map(Enum.to_list(minX..maxX), fn x -> {x, floor - 1} end)] ++ [Enum.map(Enum.to_list(minX..maxX), fn x -> {x, floor} end)]
    state = Map.update!(buildState(%{}, grid, List.flatten(rockLines), floor), {500, 0}, fn _ -> "+" end)
    {state, grid} = placeSandPart2({state, grid}, {500, 0}, floor)
    print(grid, state)
    Map.values(state) |> Enum.filter(fn x -> x == "o" end) |> Enum.count
  end

  defp print([], _) do
    IO.puts("\n")
  end
  defp print([row | rows], state) do
    row |> Enum.map(fn x -> Map.fetch(state, x) |> elem(1) end) |> Enum.join("") |> IO.puts
    print(rows, state)
  end

  defp placeSandPart1(state, {x, y}) do
    cond do
      state[{x, y + 1}] == nil ->
        state
      state[{x, y + 1}] == "o" || state[{x, y + 1}] == "#" ->
        cond do
          state[{x-1, y + 1}] != "o" && state[{x-1, y + 1}] != "#" ->
            placeSandPart1(state, {x - 1, y + 1})
          state[{x + 1, y + 1}] != "o" && state[{x+1, y + 1}] != "#" ->
            placeSandPart1(state, {x + 1, y + 1})
          true ->
            Map.update!(state, {x, y}, fn _ -> "o" end) |> placeSandPart1({500, 0})
        end
      true ->
        placeSandPart1(state, {x, y + 1})
    end
  end

  defp placeSandPart2({state, grid}, {x, y}, floor) do
    cond do
      state[{x, y + 1}] == nil ->
        placeSandPart2(
          extend({state, grid}, floor),
          {x, y},
          floor
        )
      y + 1 == floor ->
        placeSandPart2(
          { Map.update!(state, {x, y}, fn _ -> "o" end), grid},
          {500, 0},
          floor
        )
      state[{x, y + 1}] == "o" || state[{x, y + 1}] == "#" ->
        cond do
          state[{x-1, y + 1}] != "o" && state[{x-1, y + 1}] != "#" ->
            placeSandPart2(
              {state, grid},
              {x - 1, y + 1},
              floor
            )
          state[{x + 1, y + 1}] != "o" && state[{x+1, y + 1}] != "#" ->
            placeSandPart2(
              {state, grid},
              {x + 1, y + 1},
              floor
            )
          {x, y} == {500, 0} ->
            { Map.update!(state, {x, y}, fn _ -> "o" end), grid}
          true ->
            placeSandPart2(
              {Map.update!(state, {x, y}, fn _ -> "o" end), grid},
              {500, 0},
              floor
            )
        end
      true ->
        placeSandPart2(
          {state, grid},
          {x, y + 1},
          floor
        )
    end
  end

  defp extend({state, grid}, floor) do
    extendedGrid = Enum.with_index(grid) |>
      Enum.map(fn {row, y} ->
        {minX, _} = Enum.min(row)
        {maxX, _} = Enum.max(row)
        [{minX - 1, y} | row] ++ [{maxX + 1, y}]
      end)

    extendedState = buildState(state, extendedGrid, [], floor)

    {extendedState, extendedGrid}
  end

  defp buildState(state, [], _, _) do
    state
  end
  defp buildState(state, [row | rows], rockLines, floor) do
    addCellToState(state, row, rockLines, floor) |> buildState(rows, rockLines, floor)
  end

  defp addCellToState(state, [], _, _) do
    state
  end
  defp addCellToState(state, [{x, y} | row], rockLines, floor) do
    cond do
      Map.has_key?(state, {x, y}) ->
        state
      Enum.member?(rockLines, {x, y}) ->
        Map.put(state, {x, y}, "#")
      y == floor ->
        Map.put(state, {x, y}, "#")
      true ->
        Map.put(state, {x, y}, '.')
    end |> addCellToState(row, rockLines, floor)
  end

  defp fill([]) do
    []
  end
  defp fill([{{x1, y},{x2, y}} | rocks]) do
    [ Enum.to_list(x1..x2) |> Enum.map(fn x -> {x, y} end) | fill(rocks)]
  end
  defp fill([{{x, y1},{x, y2}} | rocks]) do
    [ Enum.to_list(y1..y2) |> Enum.map(fn y -> {x, y} end) | fill(rocks)]
  end

  defp parseInput(input_path) do
    File.read!(input_path) |>
      String.trim |>
      String.split("\n") |>
      Enum.map(
        fn x ->
          String.split(x, " -> ") |>
          Enum.map(&String.split(&1, ",") |> Enum.map(fn y -> String.to_integer(y) end) |> List.to_tuple)
      end)
  end
end

IO.puts(Day14.part1("day14_input.txt"))
IO.puts(Day14.part2("day14_input.txt"))
