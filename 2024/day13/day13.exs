defmodule DigitFilter do
  def filter_digits(string) do
    Regex.replace(~r/\D/, string, "")
  end
end

defmodule Solver do
  def solve([[x_a, y_a], [x_b, y_b], [x, y]]) do
    pairs = for a <- 1..100, b <- 1..100, do: {a, b}
    Enum.filter(pairs, fn {a, b} -> a * x_a + b * x_b == x && a * y_a + b * y_b == y end)
  end
end

defmodule Day13 do
  def part1(input_path) do
    parseInput(input_path)
      |> Enum.map(&Solver.solve(&1))
      |> Enum.filter(&Enum.count(&1) > 0)
      |> Enum.map(fn buttons -> Enum.map(buttons, fn {a, b} -> 3 * a + b end) |> Enum.min end)
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path)
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n\n")
      |> Enum.map(
        &String.split(&1, "\n")
        |> Enum.map(fn
          line -> String.split(line, ": ")
            |> Enum.at(1)
            |> String.split(", ")
            |> Enum.map(fn instr -> DigitFilter.filter_digits(instr) |> String.to_integer() end)
        end)
      )
  end
end

IO.puts(Day13.part1("day13_input.txt"))
# IO.puts(Day13.part2("day13_input.txt"))
