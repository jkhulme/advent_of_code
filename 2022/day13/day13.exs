defmodule Day13 do
  def part1(input_path) do
    parseInput(input_path) |>
      Enum.map(fn [left, right] -> compare(left, right) |> correctOrder end) |>
      Enum.with_index(1) |>
      Enum.filter(fn {x, _} -> x end) |>
      Enum.map(fn {_, x} -> x end) |>
      Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path) |>
      Enum.reduce([[[2]], [[6]]], fn x, acc -> acc ++ x end) |>
      Enum.sort(fn (a, b) -> compare(a, b) |> correctOrder end) |>
      Enum.with_index(1) |>
      Enum.filter(fn {x, _} -> x == [[2]] || x == [[6]] end) |>
      Enum.map(fn {_, x} -> x end) |>
      Enum.product
  end

  defp correctOrder(cs) do
    Enum.reject(cs, fn c -> c == nil end) |> Enum.at(0)
  end

  def compare([], []) do
    []
  end
  def compare([l | ls], [r | rs]) do
    [ compare(l, r) | compare(ls, rs) ] |> List.flatten
  end
  def compare([_ | _], []) do
    [false]
  end
  def compare([], [_ | _]) do
    [true]
  end
  def compare([l | ls], r) do
    compare([l | ls], [r])
  end
  def compare([], _) do
    [true]
  end
  def compare(_, []) do
    [false]
  end
  def compare(l, [r | rs]) do
    compare([l], [r | rs])
  end
  def compare(l, r) do
    cond do
      l == r ->
        nil
      l < r ->
        true
      true ->
        false
      end
  end

  defp parseInput(input_path) do
    File.read!(input_path) |>
      String.trim |>
      String.split("\n\n") |>
      Enum.map(fn x -> String.split(x, "\n") |> Enum.map(fn y -> Code.eval_string(y) |> elem(0) end) end)
  end
end

IO.puts(Day13.part1("day13_input.txt"))
IO.puts(Day13.part2("day13_input.txt"))
