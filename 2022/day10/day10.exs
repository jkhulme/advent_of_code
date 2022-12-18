defmodule Day10 do
  def part1(input_path) do
    parseInput(input_path) |> execute([]) |> Enum.reverse |> Enum.filter(fn {c, _} -> Enum.member?([20, 60, 100, 140, 180, 220], c + 1)  end) |> Enum.map(fn {c, x} -> (c + 1) * x end) |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path) |> execute([]) |> Enum.reverse |> Enum.chunk_every(40) |> Enum.with_index |> Enum.map(fn {r, i} -> Enum.map(r, fn x -> visible(x, i) end) |> Enum.join("") |> IO.puts end)
  end

  defp visible({c, x}, i) do
    cond do
      Enum.member?([x - 1, x, x + 1], c - (40*i)) ->
        "#"
      true ->
        "."
      end
  end

  defp execute([], x) do
    x
  end
  defp execute([[_, n] | instructions], []) do
    execute(instructions, [{2, 1 + String.to_integer(n)}, {1, 1}])
  end
  defp execute([[_, n] | instructions], [{c, x} | xs]) do
    execute(instructions, [{c + 2, x + String.to_integer(n)} | [{c + 1, x} | [{c, x} | xs]]])
  end
  defp execute([[_] | instructions], []) do
    execute(instructions, [{1, 1}])
  end
  defp execute([[_] | instructions], [{c, x} | xs]) do
    execute(instructions, [{c + 1, x} | [{c, x} | xs]])
  end

  defp parseInput(input_path) do
    File.read!(input_path) |> String.split("\n") |> Enum.drop(-1) |> Enum.map(fn x -> String.split(x, " ") end)
  end

end

IO.puts(Day10.part1("day10_input.txt"))
# First column is missing, some off by one error, but it is a P
IO.puts(Day10.part2("day10_input.txt"))
