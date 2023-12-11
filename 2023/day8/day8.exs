defmodule Day8 do
  def part1(input_path) do
    [steps, nodes] = parseInput(input_path)
    walk(steps, nodes, :AAA, 0)
  end

  def walk(_, _, :ZZZ, i) do
    i
  end
  def walk([side | sides], nodes, currentNode, i) do
    walk(sides ++ [side], nodes, Map.get(Map.get(nodes, currentNode), side), i + 1)
  end

  def part2(input_path) do
    [steps, nodes] = parseInput(input_path)
    starters = Map.keys(nodes) |> Enum.reject(fn k -> Atom.to_string(k) |> String.last() != "A" end)
    lcm(Enum.map(starters, fn starter -> walk2(steps, nodes, starter, 0) end))
  end

  def lcm([x, y | xs]) do
    n = (x * y) / Integer.gcd(x, y)
    lcm(xs ++ [Kernel.round(n)])
  end
  def lcm([x]) do
    x
  end

  def walk2([side | sides], nodes, currentNode, i) do
    newNode = Map.get(Map.get(nodes, currentNode), side)
    if Atom.to_string(newNode) |> String.last() == "Z" do
      i + 1
    else
      walk2(sides ++ [side], nodes, newNode, i + 1)
    end
  end

  defp parseInput(input_path) do
    input = File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
    steps = Enum.at(input, 0) |> String.graphemes() |> Enum.map(&String.to_atom/1)
    nodes = Enum.drop(input, 2)
      |> Enum.map(&String.split(&1, " = "))
      |> Enum.map(fn [node, lr] ->
        [l, r] = String.split(lr, ", ")
        {String.to_atom(node), %{L: String.slice(l, 1..-1) |> String.to_atom, R: String.slice(r, 0..2) |> String.to_atom}}
      end)
    [steps, nodes |> Map.new]
  end
end

IO.inspect(Day8.part1("day8_input.txt"))
IO.inspect(Day8.part2("day8_input.txt"))
