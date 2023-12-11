defmodule Day10 do
  def part1(input_path) do
    nodes = parseInput(input_path)
    s = findS(nodes)
    search([s], Map.put(nodes, s, {"S", 0}), %{})
      |> Map.values
      |> Enum.map(fn {_, step} -> step end)
      |> Enum.max
  end

  def search([], nodes, _) do
    nodes
  end
  def search([{x, y} | neighbours], nodes, seen) do
    if Map.has_key?(seen, {x, y}) do
      search(neighbours, nodes, seen)
    else
      {_, currentStep} = Map.get(nodes, {x, y})
      nextNodes = connectedNodes({x, y}, nodes)
      nextSteps = Enum.reject(nextNodes, fn {x, y} ->
        {_, step} = Map.get(nodes, {x, y})
        step != -1 and currentStep <= step + 1
      end)

      newNodes = Enum.reduce(nextSteps, nodes, fn x, acc ->
        {el, _} = Map.get(acc, x)
        Map.put(acc, x, {el, currentStep + 1})
      end)

      search(neighbours ++ nextSteps, newNodes, Map.put(seen, {x, y}, true))
    end
  end

  def connectedNodes({x, y}, nodes) do
    case Map.get(nodes, {x, y}) do
      "-" ->
       [{x - 1, y}, {x + 1, y}]
      "|" ->
       [{x, y - 1}, {x, y + 1}]
      "L" ->
        [{x, y - 1}, {x + 1, y}]
      "J" ->
        [{x, y - 1}, {x - 1, y}]
      "7" ->
        [{x - 1, y}, {x, y + 1}]
      "F" ->
        [{x + 1, y}, {x, y + 1}]
      _ ->
        sNeighbours([{{x, y - 1}, "|7F"}, {{x + 1, y}, "-7J"}, {{x, y + 1}, "|JL"}, {{x - 1, y}, "-FL"}], nodes, [])
    end
  end

  def sNeighbours([], _, acc) do
    acc
  end
  def sNeighbours([{ {x, y}, pipe } | neighbours], nodes, acc) do
    if !Map.has_key?(nodes, {x, y}) do
      sNeighbours(neighbours, nodes, acc)
    else
      {node, _} = Map.get(nodes, { x, y })

      if String.contains?(pipe, node) do
        sNeighbours(neighbours, nodes, [{x, y} | acc])
      else
        sNeighbours(neighbours, nodes, acc)
      end
    end
  end

  def part2(input_path) do
    parseInput(input_path)
  end

  defp findS(nodes) do
    Map.keys(nodes) |> Enum.find(fn k ->
      {v, _} = Map.get(nodes, k)
      v == "S"
    end)
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.with_index(fn (row, y) -> Enum.with_index(row) |> Enum.map(fn {el, x} -> {{x, y}, {el, -1}} end) |> Map.new end)
      |> Enum.reduce(%{}, fn row, acc -> Map.merge(acc, row) end)
  end
end

IO.inspect(Day10.part1("day10_input.txt"))
# IO.inspect(Day10.part2("day10_input.txt"))
