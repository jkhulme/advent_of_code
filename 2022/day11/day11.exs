defmodule Monkey do
  defstruct [:id, :items, :operation, :test, :testTrue, :testFalse, :inspected]
end

defmodule Day11 do
  def part1(input_path) do
    parseInput(input_path) |> performRounds(20, true) |> Map.values |> Enum.map(fn m -> m.inspected end) |> Enum.sort |> Enum.take(-2) |> Enum.product
  end

  def part2(input_path) do
    parseInput(input_path) |> performRounds(1000, false) |> Map.values |> Enum.map(fn m -> m.inspected end) |> Enum.sort |> Enum.take(-2) |> Enum.product
  end

  defp printMonkeys(ms) do
    ms |> Map.values |> Enum.map(fn m -> IO.inspect("#{m.id} #{Enum.join(m.items, ",")} #{m.inspected}") end)
  end

  defp performRounds(m, 0, _) do
    m
  end
  defp performRounds(m, round, worry) do
    performRound(m, worry) |> performRounds(round - 1, worry)
  end

  defp performRound(m, worry) do
    performMonkeys(m, (0..(Map.keys(m) |> Enum.count) - 1) |> Enum.to_list, worry)
  end

  defp performMonkeys(m, [], _) do
    m
  end
  defp performMonkeys(m, [i | is], worry) do
    performMonkey(m, i, worry) |> performMonkeys(is, worry)
  end

  defp performMonkey(m, i, worry) do
    performItem(m[i].items, m, i, worry)
  end

  defp performItem([], m, _, _) do
    m
  end
  defp performItem([item | items], m, i, worry) do
    { interest, newM } = interest(item, m[i].operation, worry) |> throw(m[i].test, m[i].testTrue, m[i].testFalse)
    performItem(
      items,
      Map.update!(m, i, fn monkey -> %{ monkey | items: items, inspected: monkey.inspected + 1 } end) |> Map.update!(newM, fn monkey -> %{ monkey | items: [interest | monkey.items]} end),
      i,
      worry
    )
  end

  defp interest(item, [operation, operand], worry) do
    x = cond do
      operand === "old" ->
        item
      true ->
        operand
    end

    v = cond do
      operation == "*" ->
        item * x
      true ->
        item + x
    end

    cond do
      worry ->
        div(v, 3)
      true ->
        v
    end
  end

  defp throw(item, test, testTrue, _) when rem(item, test) === 0, do: {item, testTrue}
  defp throw(item, test, _, testFalse) when rem(item, test) !== 0, do: {item, testFalse}

  defp parseInput(input_path) do
    File.read!(input_path) |>
      String.trim |>
      String.split("\n\n") |>
      Enum.map(fn m -> parseMonkey(m) end) |>
      Enum.into(%{}, fn m -> {m.id, m} end)
  end

  defp parseMonkey(m) do
    [id, items, operation, test, testTrueHandler, testFalseHandler] = m |> String.split("\n")
    [operator, operand] = String.split(operation, " = ") |> Enum.at(1) |> String.split(" ") |> Enum.drop(1)
    %Monkey{
      id: String.split(id, " ") |> Enum.at(1) |> String.split(":") |> Enum.at(0) |> String.to_integer,
      items: String.split(items, ": ") |> Enum.at(1) |> String.split(", ") |> Enum.map(fn i -> String.to_integer(i) end),
      operation: [operator, cond do
        operand === "old" ->
          operand
        true ->
          String.to_integer(operand)
        end
      ],
      test: String.split(test, "by ") |> Enum.at(1) |> String.to_integer,
      testTrue: String.split(testTrueHandler, "monkey ") |> Enum.at(1) |> String.to_integer,
      testFalse: String.split(testFalseHandler, "monkey ") |> Enum.at(1) |> String.to_integer,
      inspected: 0
    }
  end
end

IO.puts(Day11.part1("day11_input.txt"))
# IO.puts(Day11.part2("day11_input.txt"))
