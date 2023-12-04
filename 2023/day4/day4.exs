defmodule Day4 do
  def part1(input_path) do
    parseInput(input_path)
      |> Enum.map(fn [ticket, draw] -> MapSet.intersection(MapSet.new(ticket), MapSet.new(draw)) |> MapSet.size end)
      |> Enum.map(fn numberOfMatches -> :math.pow(2, numberOfMatches - 1) |> :math.floor |> round end)
      |> Enum.sum
  end

  def part2(input_path) do
    parseInput(input_path) |> Enum.map(fn c -> [c] end) |> duplicateCards([]) |> Enum.map(fn x -> x end) |> Enum.count
  end

  defp duplicateCards([], outCards) do
    outCards
  end
  defp duplicateCards([card | cards], outCards) do
    [ticket, draw] = Enum.at(card, 0)
    n = MapSet.intersection(MapSet.new(ticket), MapSet.new(draw)) |> MapSet.size
    duplicateCards(
      Enum.concat(Enum.take(cards, n) |> Enum.map(fn [c | cs] -> List.duplicate(c, Enum.count(card) + 1) ++ cs end), Enum.drop(cards, n)),
      card ++ outCards
    )
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn card -> String.split(card, ": ") end)
      |> Enum.map(
        fn [_, game] -> String.split(String.trim(game), " | ")
          |> Enum.map(fn numbers -> String.split(numbers) |> Enum.map(fn number -> String.to_integer(String.trim(number)) end) end)
        end)
  end
end

IO.inspect(Day4.part1("day4_input.txt"))
IO.inspect(Day4.part2("day4_input.txt"))
