defmodule Day4 do
  def part1(input_path) do
    [numbers | boards] = input_path |> parseInput()
    mark_boards_part1(parse_numbers(numbers), parse_boards(boards))
  end

  def part2(input_path) do
    [numbers | boards] = input_path |> parseInput()
    mark_boards_part2(parse_numbers(numbers), parse_boards(boards))
  end

  defp mark_boards_part2([n | numbers], boards) do
    updated_boards = Enum.map(boards, fn board -> mark_board(board, n) end)
    case updated_boards |> Enum.filter(fn board -> !winning_board(board) end) do
      [winner] ->
        mark_boards_part1(numbers, [winner])
      _ ->
        mark_boards_part2(numbers, updated_boards)
    end
  end
  defp mark_boards_part2([], boards) do
    boards
  end

  defp mark_boards_part1([n | numbers], boards) do
    updated_boards = Enum.map(boards, fn board -> mark_board(board, n) end)
    case updated_boards |> Enum.filter(fn board -> winning_board(board) end) do
      [] ->
        mark_boards_part1(numbers, updated_boards)
      [b] ->
        score_board(b) * n
    end
  end
  defp mark_boards_part1([], boards) do
    boards
  end

  defp mark_board(board, n) do
    board |> Enum.map(fn row -> Enum.map(row, fn {elem, seen} -> {elem, seen || elem == n} end) end)
  end

  defp winning_board(board) do
    Enum.any?(board, fn row -> winning_row(row) end) || Enum.any?(Enum.zip(board), fn row -> winning_row(Tuple.to_list(row)) end)
  end

  defp winning_row(row) do
    row |> Enum.all?(fn {elem, seen} -> seen end)
  end

  defp score_board(board) do
    board
      |> Enum.map(fn row -> Enum.filter(row, fn {elem, seen} -> !seen end) |> Enum.map(fn {elem, seen} -> elem end) end)
      |> List.flatten |> Enum.sum
  end

  defp parse_numbers(ns) do
    Enum.at(ns, 0) |> String.trim() |> String.split(",") |> Enum.map(fn n -> String.to_integer(n) end)
  end

  defp parse_boards(boards) do
    boards
      |> remove_blanks
      |> Enum.map(fn board -> split_board(board) end)
  end

  defp remove_blanks(boards) do
    boards |> Enum.filter(fn board -> Enum.count(board) > 1 end)
  end

  defp split_board(board) do
    Enum.map(board, fn row -> String.trim(row) |> String.split(" ") |> parse_row end)
  end

  defp parse_row(row) do
    row |> Enum.filter(fn s -> String.length(s) > 0 end) |> Enum.map(fn s -> {String.to_integer(s), false} end)
  end

  defp parseInput(path) do
    File.read!(path) |> String.trim() |> String.split("\n") |> Enum.chunk_by(fn x -> x == "" end)
  end
end

IO.puts(Day4.part1("day4_input.txt"))
IO.puts(Day4.part2("day4_input.txt"))
