defmodule Day11 do
  def part1(input_path) do
    parseInput(input_path)
      |> Enum.map(&blink(&1, 25))
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
      |> Enum.map(&blink(&1, 75))
      |> Enum.sum
  end

  def blink(_, 0) do
    1
  end
  def blink(n, i) do
    cond do
      n == "0" -> blink("1", i - 1)
      Integer.mod(String.length(n), 2) == 0 ->
        {l, r} = String.split_at(n, Integer.floor_div(String.length(n), 2))
        blink(trim_zeros(r), i - 1) + blink(trim_zeros(l), i - 1)
      true ->
        blink(Integer.to_string(String.to_integer(n) * 2024), i - 1)
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
