defmodule Day8 do
  def part1(input_path) do
    parseInput(input_path, false) |> visibleTrees |> transpose |> visibleTrees |> countVisible
  end

  def part2(input_path) do
    parseInput(input_path, 1) |> treeScenicScores |> transpose |> treeScenicScores |> maxScenicScore
  end

  defp maxScenicScore(trees) do
    trees |> Enum.map(fn r -> Enum.map(r, fn {_, s} -> s end) |> Enum.max end) |> Enum.max
  end

  defp countVisible(trees) do
    trees |> Enum.map(fn r -> Enum.reject(r, fn {_, s} -> !s end) |> Enum.count end) |> Enum.sum
  end

  defp treeScenicScores(trees) do
    Enum.map(trees, fn x -> rowScore(x, []) end)
  end

  defp rowScore([], seenTrees) do
    Enum.reverse(seenTrees)
  end
  defp rowScore([{t, s} | trees], seenTrees) do
    cond do
      seenTrees == [] || trees == [] ->
        rowScore(trees, [{t, 0} | seenTrees])
      true ->
        rowScore(trees, [{t, s * treeScore(t, trees, 0) * treeScore(t, seenTrees, 0)} | seenTrees])
    end
  end

  defp treeScore(t, [], s) do
    s
  end
  defp treeScore(t, [{tree, _} | trees], s) do
    cond do
      t <= tree ->
        s + 1
      true ->
        treeScore(t, trees, s + 1)
    end
  end

  defp visibleTrees(trees) do
    Enum.map(trees, fn x -> rowVisible(x, []) end)
  end

  defp rowVisible([], seenTrees) do
    seenTrees
  end
  defp rowVisible([{t, s} | trees], seenTrees) do
    cond do
      seenTrees == [] || trees == [] ->
        rowVisible(trees, [{t, true} | seenTrees])
      Enum.all?(trees, fn {x, _} -> t > x end) || Enum.all?(seenTrees, fn {x, _} -> t > x end) ->
        rowVisible(trees, [{t, true} | seenTrees])
      true ->
        rowVisible(trees, [{t, s} | seenTrees])
    end
  end

  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
  
  defp parseInput(input_path, initialScore) do
    File.read!(input_path) |> String.split("\r\n") |> Enum.map(fn r -> String.codepoints(r) |> Enum.map(fn t -> {String.to_integer(t), initialScore} end) end)
  end

end

IO.puts(Day8.part1("day8_input.txt"))
IO.puts(Day8.part2("day8_input.txt"))
