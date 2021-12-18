defmodule Day2 do
  def part1(input_path) do
    input_path |> parseInput |> calc_position_part1(0, 0)
  end

  def part2(input_path) do
    input_path |> parseInput |> calc_position_part2(0, 0, 0)
  end

  defp calc_position_part1([head | tail], h_pos, v_pos) do
    case head do
      ["forward", x] -> calc_position_part1(tail, h_pos + x, v_pos)
      ["up", y] -> calc_position_part1(tail, h_pos, v_pos - y)
      ["down", y] -> calc_position_part1(tail, h_pos, v_pos + y)
    end
  end

  defp calc_position_part1([], h_pos, v_pos) do
    h_pos * v_pos
  end

  defp calc_position_part2([head | tail], aim, h_pos, v_pos) do
    case head do
      ["forward", x] -> calc_position_part2(tail, aim, h_pos + x, v_pos + (aim * x))
      ["up", y] -> calc_position_part2(tail, aim - y, h_pos, v_pos)
      ["down", y] -> calc_position_part2(tail, aim + y, h_pos, v_pos)
    end
  end

  defp calc_position_part2([], aim, h_pos, v_pos) do
    h_pos * v_pos
  end

  defp parseInput(path) do
    File.read!(path) |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.split(x, " ") end) |> Enum.map(fn [d, x] -> [d, String.to_integer(x)] end)
  end
end

IO.puts(Day2.part1("day2_input.txt"))
IO.puts(Day2.part2("day2_input.txt"))
