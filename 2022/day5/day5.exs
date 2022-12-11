defmodule Day5 do
  def part1(input_path) do
    parseInput(input_path) |> moveContainers(&moveContainer1/2) |> Enum.map(fn x -> Enum.at(x, 0) end) |> Enum.join("") |> String.replace(~r/\[|\]/, "")
  end

  def part2(input_path) do
    parseInput(input_path) |> moveContainers(&moveContainer2/2) |> Enum.map(fn x -> Enum.at(x, 0) end) |> Enum.join("") |> String.replace(~r/\[|\]/, "")
  end

  defp moveContainers({c, [i | is]}, moveFunc) do
    moveContainers({moveFunc.(c, i), is}, moveFunc)
  end
  defp moveContainers({c, []}, _) do
    c
  end

  defp moveContainer1(c, [0, _, _]) do
    c
  end
  defp moveContainer1(c, [n, from, to]) do
    crate = Enum.at(c, from - 1) |> Enum.take(1)
    d = Enum.with_index(c, 1) |> Enum.map(fn {x, i} -> 
      cond do
        i == from ->
          Enum.drop(x, 1)
        i == to ->
          crate ++ x
        true ->
          x
      end
    end)
    moveContainer1(d, [n - 1, from, to])
  end

  defp moveContainer2(c, [n, from, to]) do
    crates = Enum.at(c, from - 1) |> Enum.take(n)
    Enum.with_index(c, 1) |> Enum.map(fn {x, i} -> 
      cond do
        i == from ->
          Enum.drop(x, n)
        i == to ->
          crates ++ x
        true ->
          x
      end
    end)
  end
  
  defp parseInput(input_path) do
    [ cs, _, ms ] = File.read!(input_path) |> String.split("\n") |> Enum.chunk_by(fn x -> x == "\r" end) |> Enum.map(fn x -> Enum.map(x, fn y -> String.trim(y, "\r") end) end)
    containers = Enum.drop(cs, -1) |> Enum.map(fn c -> String.codepoints(c) |> Enum.chunk_every(4) |> Enum.map(fn x -> Enum.join(x, "") |> String.trim() end) end) |> Enum.zip |> Enum.map(&Tuple.to_list/1) |> Enum.map(fn c -> Enum.drop_while(c, fn x -> x == "" end)end)
    moves = Enum.map(ms, fn m -> String.trim(m) |> String.split(" from ") end) |> Enum.map(fn [m1, m2] -> [String.split(m1, "move ") |> Enum.drop(1), String.split(m2, " to ")] |> List.flatten |> Enum.map(fn i -> String.to_integer(i) end) end)
    { containers, moves }
  end
end

IO.puts(Day5.part1("day5_input.txt"))
IO.puts(Day5.part2("day5_input.txt"))
