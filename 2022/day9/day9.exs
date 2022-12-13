defmodule Day9 do
  def part1(input_path) do
    parseInput(input_path) |> headPath([{0,0}]) |> follow([{0, 0}]) |> Enum.uniq |> Enum.count
  end

  def part2(input_path) do
    parseInput(input_path) |> 
      headPath([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |>
      follow([{0,0}]) |> Enum.uniq |> Enum.count
  end

  defp headPath([], hPath) do
    hPath |> Enum.reverse
  end
  defp headPath([{_, 0} | path], hPath) do
    headPath(path, hPath)
  end
  defp headPath([{d, n} | path], [hPos | hPath]) do
    headPath([{d, n - 1} | path], [moveH(d, hPos) | [hPos | hPath]])
  end
  
  defp follow([], tPath) do
    tPath |> Enum.reverse
  end
  defp follow([hPos | hPath], [tPos | tPath]) do
    follow(hPath, [moveT(tPos, hPos) | [tPos | tPath]])
  end

  defp moveH(d, {x, y}) do
    cond do
      d == "R" ->
        {x + 1, y}
      d == "U" ->
        {x, y + 1}
      d == "L" ->
        {x - 1, y}
      d == "D" ->
        {x, y - 1}
    end
  end

  defp moveT({tX, y}, {hX, y}) do
    cond do 
      tX - hX <= -2 ->
        {tX + 1, y}
      tX - hX >= 2 ->
        {tX - 1, y}
      true ->
        {tX, y}
      end
  end
  defp moveT({x, tY}, {x, hY}) do
    cond do 
      tY - hY <= -2 ->
        {x, tY + 1}
      tY - hY >= 2 ->
        {x, tY - 1}
      true ->
        {x, tY}
      end
  end
  defp moveT({tX, tY}, {hX, hY})
    when hX == tX + 1 and hY == tY + 1
    when hX == tX - 1 and hY == tY - 1
    when hX == tX + 1 and hY == tY - 1
    when hX == tX - 1 and hY == tY + 1 do
      {tX, tY}
  end
  defp moveT({tX, tY}, {hX, hY}) do
    cond do
      hX > tX && hY > tY ->
        {tX + 1, tY + 1}
      hX > tX && hY < tY ->
        {tX + 1, tY - 1}
      hX < tX && hY > tY ->
        {tX - 1, tY + 1}
      hX < tX && hY < tY ->
        {tX - 1, tY - 1}
    end
  end
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.split("\r\n") |> Enum.map(fn x -> String.split(x, " ") end) |> Enum.map(fn [d, n] -> {d, String.to_integer(n)} end)
  end

end

IO.puts(Day9.part1("day9_input.txt"))
IO.puts(Day9.part2("day9_input.txt"))
