defmodule Day3 do
  def part1(input_path) do
    parseInput(input_path)
      |> parseMultiplies
      |> Enum.map(&Enum.product/1)
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
      |> parseMultipliesPart2
      |> parseMultiplies
      |> Enum.map(&Enum.product/1)
      |> Enum.sum
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
  end

  defp parseMultiplies(input) do
    Regex.scan(~r/mul\(\d+,\d+\)/, input)
      |> Enum.flat_map(
        fn [mul] -> Regex.scan(~r/\d+,\d+/, mul)
          |> Enum.map(fn [product] -> String.split(product, ",") |> Enum.map(&String.to_integer/1) end)
      end)
  end

  defp parseMultipliesPart2(input) do
    [head | donts] = String.split(input, "don't()")
    [head | Enum.map(donts, fn dont -> String.split(dont, "do()") |> Enum.drop(1) end)]
      |> Enum.join("")
  end
end

# IO.puts(Day3.part1("day3_input.txt"))
# IO.puts(Day3.part2("day3_input.txt"))
