defmodule Day12 do
  def part1(input_path) do
    grid = parseInput(input_path)
    {sPos, _} = findPos(grid, "S")
    {ePos, _} = findPos(grid, "E")
    graph = toNumberGrid(grid)
    steps = traverse1(graph, [{sPos, ?a}], {ePos, ?z}, 0, Map.put(%{}, {sPos, ?a}, 0))
    # printGraph(graph, steps)
    Map.fetch(steps, {ePos, ?z}) |> elem(1)
  end

  def part2(input_path) do
    grid = parseInput(input_path)
    {sPos, _} = findPos(grid, "E")
    {ePos, _} = findPos(grid, "S")
    graph = toNumberGrid(grid)
    steps = traverse2(graph, [{sPos, ?z}], {ePos, ?a}, 0, Map.put(%{}, {sPos, ?z}, 0))
    # printGraph(graph, steps)
    Map.keys(steps) |> Enum.filter(fn {_, x} -> x == ?a end) |> Enum.map(fn k -> Map.fetch(steps, k) |> elem(1) end) |> Enum.min
    # Map.fetch(steps, {ePos, ?a}) |> elem(1)
  end

  defp printGraph(graph, steps) do
    IO.puts("----------")
    Enum.map(graph, fn r -> Enum.map(r, fn c -> steps[c] end) |> Enum.join(", ") |> IO.puts end)
    IO.puts("----------")
  end

  defp traverse1(_, [], _, _, seen) do
    seen
  end
  defp traverse1(_, [goal|_], goal, _, seen) do
    seen
  end
  defp traverse1(grid, [n | ns], goal, steps, seen) do
    cs = candidates1(grid, n, seen)
    traverse1(
      grid,
      ns,
      goal,
      steps,
      traverse1(
        grid,
        cs,
        goal,
        steps + 1,
        move(cs, seen, steps + 1)
      )
    )
  end

  defp traverse2(_, [], _, _, seen) do
    seen
  end
  defp traverse2(_, [{_, goal}|_], {_, goal}, _, seen) do
    seen
  end
  defp traverse2(grid, [n | ns], goal, steps, seen) do
    cs = candidates2(grid, n, seen)
    traverse2(
      grid,
      ns,
      goal,
      steps,
      traverse2(
        grid,
        cs,
        goal,
        steps + 1,
        move(cs, seen, steps + 1)
      )
    )
  end

  defp move([], visited, _) do
    visited
  end
  defp move([c | cs], visited, steps) do
    move(
      cs,
      cond do
        Map.has_key?(visited, c) ->
          Map.update!(visited, c, fn x -> Enum.min([x, steps]) end)
        true ->
          Map.put(visited, c, steps)
      end,
      steps
    )
  end

  defp rejectVisited(ns, current, seen) do
    Enum.reject(ns, fn x -> closer?(Map.fetch(seen, x), Map.fetch(seen, current)) end)
  end

  defp candidates1(grid, {{y, x}, c}, seen) do
    [{y - 1, x}, {y + 1, x}, {y, x - 1}, {y, x + 1}] |>
      Enum.filter(fn {cY, cX} -> cX >= 0 && cY >= 0 end) |>
      Enum.map(fn {cY, cX} -> Enum.at(grid, cY, []) |> Enum.at(cX) end) |>
      Enum.reject(fn x -> x == nil end) |>
      Enum.reject(fn {_, e} -> e > c + 1 end) |>
      rejectVisited({{y, x}, c}, seen)
  end

  defp candidates2(grid, {{y, x}, c}, seen) do
    [{y - 1, x}, {y + 1, x}, {y, x - 1}, {y, x + 1}] |>
      Enum.filter(fn {cY, cX} -> cX >= 0 && cY >= 0 end) |>
      Enum.map(fn {cY, cX} -> Enum.at(grid, cY, []) |> Enum.at(cX) end) |>
      Enum.reject(fn x -> x == nil end) |>
      Enum.reject(fn {_, e} -> e < c - 1 end) |>
      rejectVisited({{y, x}, c}, seen)
  end

  defp closer?({_, v1}, {_, v2}) do
    # This gives the correct answer, but I think it is being too generous
    v1 < v2 + 2
  end
  defp closer?(_, _) do
    false
  end

  defp findPos(grid, e) do
    grid |> Enum.to_list |> List.flatten |> Enum.find(fn {_, x} -> x == e end)
  end

  defp parseInput(input_path) do
    File.read!(input_path) |>
      String.split("\n") |>
      Enum.drop(-1) |>
      Enum.with_index |>
      Enum.map(fn {x, i}  -> String.codepoints(x) |> Enum.with_index(fn e, j -> {{i,j},e} end) end)
  end

  defp toNumberGrid(grid) do
    grid |>
      Enum.map(
        fn row -> Enum.map(
          row, fn {p, e} ->
            cond do
              e == "S" ->
                {p, ?a}
              e == "E" ->
                {p, ?z}
              true ->
                <<a::utf8>> = e
                {p, a}
            end
        end)
      end)
  end
end

IO.puts(Day12.part1("day12_input.txt"))
IO.puts(Day12.part2("day12_input.txt"))
