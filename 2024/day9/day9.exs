defmodule Day9 do
  def part1(input_path) do
    parseInput(input_path)
      |> fileBlocks(0, [])
      |> Enum.reject(fn {_, n} -> n == 0 end)
      |> shift([])
      |> Enum.reverse
      |> checksum()
  end

  def part2(input_path) do
    parseInput(input_path)
      |> fileBlocks(0, [])
      # |> Enum.reject(fn {_, n} -> n == 0 end)
      |> Enum.reverse
      |> shift2([])
      |> checksum
  end

  def checksum(disk_map) do
    disk_map
      |> Enum.flat_map(fn {x, n} -> List.duplicate(x, n) end)
      |> Enum.map(fn x ->
        case x do
          "." -> "0"
          _ -> x
        end
      end)
      |> Enum.with_index
      |> Enum.map(fn { x, i } -> String.to_integer(x) * i end)
      |> Enum.sum
  end

  def shift([], acc) do
    acc
  end
  def shift([{".", n} | xs], acc) do
    shift(takeFromBack(Enum.reverse(xs), {".", n}), acc)
  end
  def shift([{x, n} | xs], acc) do
    shift(xs, [{x, n} | acc])
  end

  def shift2([], acc) do
    acc
  end
  def shift2([{".", n} | xs], acc) do
    shift2(xs, [{".", n} | acc])
  end
  def shift2([{x, n} | xs], acc) do
    [head | tail] = move_file(Enum.reverse(xs), [], {x, n})
    cond do
      head == {x, n} -> shift2(tail, [head | acc])
      true -> shift2([head | tail], acc)
    end
  end

  def move_file([], seen, head) do
    [head | seen]
  end
  def move_file([{".", n} | xs], seen, {h, n_head}) do
    cond do
      n > n_head -> Enum.reverse(Enum.reverse(seen) ++ [{h, n_head}, {".", n - n_head} | xs] ++ [{".", n_head}])
      n == n_head -> Enum.reverse(Enum.reverse(seen) ++ [{h, n} | xs] ++ [{".", n_head}])
      true -> move_file(xs, [{".", n} | seen], {h, n_head})
    end
  end
  def move_file([{x, n} | xs], seen, head) do
    move_file(xs, [{x, n} | seen], head)
  end


  def takeFromBack([], _) do
    []
  end
  def takeFromBack([{".", _} | xs], head) do
    takeFromBack(xs, head)
  end
  def takeFromBack([{x, n} | xs], {h, n_head}) do
    cond do
      n > n_head -> [{x, n_head} | Enum.reverse([{x, n - n_head} | xs])]
      n == n_head -> [{x, n_head} | Enum.reverse(xs)]
      n < n_head -> [{x, n}, {h, n_head - n} | Enum.reverse(xs)]
    end
  end

  defp fileBlocks([], _, blocks) do
    Enum.reverse(blocks)
  end
  defp fileBlocks([b | []], i, blocks) do
    fileBlocks([], i + 1, [{Integer.to_string(i), String.to_integer(b)} | blocks])
  end
  defp fileBlocks([b, x | diskMap], i, blocks) do
    fileBlocks(diskMap, i + 1, [{".", String.to_integer(x)}, {Integer.to_string(i), String.to_integer(b)} | blocks])
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.graphemes()
  end
end

IO.puts(Day9.part1("day9_input.txt"))
IO.puts(Day9.part2("day9_input.txt"))
