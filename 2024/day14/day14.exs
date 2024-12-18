defmodule Simulator do
  def run([[x, y], [x_v, y_v]], {x_lim, y_lim}, s) do
    {
      x + (x_v * s) |> teleport(x_lim),
      y + (y_v * s) |> teleport(y_lim)
    }
  end

  defp teleport(p, lim) do
    cond do
      p < 0 ->
        case rem(p, lim) do
          0 ->
            0
          _ ->
            lim + rem(p, lim)
        end
      p >= lim ->
        rem(p, lim)
      true ->
        p
    end
  end
end

defmodule Quadrant do
  def map_quadrant({x, y}, {x_lim, y_lim}) do
    x_break = (x_lim - 1) / 2
    y_break = (y_lim - 1) / 2

    cond do
      x < x_break && y < y_break ->
        "TL"
      x < x_break && y > y_break ->
        "BL"
      x > x_break && y < y_break ->
        "TR"
      x > x_break && y > y_break ->
        "BR"
      true ->
        -1
    end
  end

  def safety_score(quadrants) do
    quadrants
      |> Enum.reject(fn q -> q == -1 end)
      |> Enum.group_by(fn q -> q end)
      |> Map.values
      |> Enum.map(&Enum.count/1)
      |> Enum.product
  end
end

defmodule Day14 do
  def part1(input_path, limits) do
    parseInput(input_path)
      |> Enum.map(&Simulator.run(&1, limits, 100))
      |> Enum.map(&Quadrant.map_quadrant(&1, limits))
      |> Quadrant.safety_score()
  end

  def part2(input_path, limits) do
    parseInput(input_path)
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(
        &String.split(&1, " ")
          |> Enum.map(
            fn x -> String.split(x, "=")
              |> Enum.at(1)
              |> String.split(",")
              |> Enum.map(fn n -> String.to_integer(n) end)
            end
          )
      )
  end
end

IO.puts(Day14.part1("day14_input.txt", {101, 103}))
# IO.puts(Day14.part2("day14_input.txt", {101, 103}))
