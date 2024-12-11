defmodule Day11 do
  def part1(input_path) do
    parseInput(input_path)
      |> blink_stones(6, %{}, [])
      |> Enum.sum
      # |> Enum.map(&Enum.at(&1, 0))
      # |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
      |> blink_stones(75, %{}, [])
      |> Enum.sum
  end

  def blink_stones([], _, _, acc) do
    acc
  end
  def blink_stones([s | ss], n, stones, acc) do
    [count, updated_stones] = blink(s, n, stones)
    IO.inspect(updated_stones)
    blink_stones(ss, n, updated_stones, [count | acc])
  end

  def blink(s, 0, stones) do
    [1, Map.put(stones, {s, 0}, 1)]
  end
  def blink(s, t, stones) do
    cond do
      Map.get(stones, {s, t}) ->
        [Map.get(stones, {s, t}), stones]
      s == "0" ->
        blink("1", t - 1, Map.put(stones, {s, t}, 1))
      Integer.mod(String.length(s), 2) == 0 ->
          {l, r} = String.split_at(s, Integer.floor_div(String.length(s), 2))
          [n1, map1] = blink(trim_zeros(r), t - 1, Map.put(stones, {s, t}, 2))
          [n2, map2] = blink(trim_zeros(l), t - 1, map1)
          [n1 + n2, map2]
      true ->
          blink(Integer.to_string(String.to_integer(s) * 2024), t - 1, Map.put(stones, {s, t}, 1))
    end
  end

  def trim_zeros(s) do
    Regex.replace(~r/^0+(?=\d)/, s, "")
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split(" ")
  end
end

# IO.puts(Day11.part1("day11_input.txt"))
# IO.puts(Day11.part2("day11_input.txt"))
