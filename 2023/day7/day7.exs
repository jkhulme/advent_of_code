defmodule Day7 do
  def part1(input_path) do
    parseInput(input_path)
      |> Enum.map(fn { sorted, orig, bid} -> [scorePart1(sorted), orig, bid] end)
      |> Enum.sort_by(&Enum.drop(&1, -1), fn x, y -> sortHands(x, y, cardStrengthPart1()) end)
      |> Enum.with_index |> Enum.map(fn {[_, _, bid], i} -> bid * (i + 1) end)
      |> Enum.sum
  end

  defp cardStrengthPart1 do
    %{
      A: 0,
      K: 1,
      Q: 2,
      J: 3,
      T: 4,
      "9": 5,
      "8": 6,
      "7": 7,
      "6": 8,
      "5": 9,
      "4": 10,
      "3": 11,
      "2": 12,
    }
  end

  defp cardStrengthPart2 do
    %{
      A: 0,
      K: 1,
      Q: 2,
      T: 3,
      "9": 4,
      "8": 5,
      "7": 6,
      "6": 7,
      "5": 8,
      "4": 9,
      "3": 10,
      "2": 11,
      J: 12,
    }
  end

  defp sortHands([scoreX, handX], [scoreY, handY], cardStrength) do
    if scoreX == scoreY do
      compareHands(handX, handY, cardStrength)
    else
      scoreX < scoreY
    end
  end

  defp compareHands([], [], _) do
    true
  end
  defp compareHands([x | handX], [x | handY], cardStrength) do
    compareHands(handX, handY, cardStrength)
  end
  defp compareHands([x | _], [y | _], cardStrength) do
    Map.get(cardStrength, x) > Map.get(cardStrength, y)
  end

  def part2(input_path) do
    parseInput(input_path)
      |> Enum.map(fn { sorted, orig, bid} -> [scorePart2(sorted), orig, bid] end)
      |> Enum.sort_by(&Enum.drop(&1, -1), fn x, y -> sortHands(x, y, cardStrengthPart2()) end)
      |> Enum.with_index |> Enum.map(fn {[_, _, bid], i} -> bid * (i + 1) end)
      |> Enum.sum
  end

  defp scorePart2(hand) do
    freqs = Enum.frequencies(hand)
    jokers = Map.get(freqs, :J, 0)
    hand = Map.delete(freqs, :J)

    counts = Map.values(hand)
    cond do
      # 5 jokers
      Enum.count(counts) == 0 ->
        6
      # 5 of a kind
      Enum.count(counts) == 1 ->
        6
      # 4 of a kind
      Enum.count(counts) == 2 and Enum.any?(counts, fn x -> x + jokers >= 4 end) ->
        5
      # full house
      Enum.count(counts) == 2 ->
        4
      # 3 of a kind
      Enum.count(counts) == 3 and Enum.any?(counts, fn x -> x + jokers >= 3 end) ->
        3
      # 2 pair
      Enum.count(counts) == 3 ->
        2
      # 1 pair
      Enum.count(counts) == 4 and Enum.any?(counts, fn x -> x + jokers >= 2 end) ->
        1
      #  high card
      Enum.count(counts) == 5 ->
        0
      true ->
        0
      end
  end

  # 5 of a kind
  defp scorePart1([c, c, c, c, c]) do
    6
  end
  # 4 of a kind
  defp scorePart1([c, c, c, c, _]) do
    5
  end
  defp scorePart1([_, c, c, c, c]) do
    5
  end
  # full house
  defp scorePart1([c, c, c, x, x]) do
    4
  end
  defp scorePart1([x, x, c, c, c]) do
    4
  end
  # 3 of a kind
  defp scorePart1([c, c, c, _, _]) do
    3
  end
  defp scorePart1([_, c, c, c, _]) do
    3
  end
  defp scorePart1([_, _, c, c, c]) do
    3
  end
  # 2 pair
  defp scorePart1([a, a, b, b, _]) do
    2
  end
  defp scorePart1([b, b, _, a, a]) do
    2
  end
  defp scorePart1([_, a, a, b, b]) do
    2
  end
  # 1 pair
  defp scorePart1([c, c, _, _, _]) do
    1
  end
  defp scorePart1([_, c, c, _, _]) do
    1
  end
  defp scorePart1([_, _, c, c, _]) do
    1
  end
  defp scorePart1([_, _, _, c, c]) do
    1
  end
  # High card
  defp scorePart1(_) do
    0
  end

  defp parseInput(input_path) do
    File.read!(input_path)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(fn hand -> String.split(hand, " ") end)
      |> Enum.map(fn [hand, bid] -> { String.graphemes(hand)  |> Enum.map(fn x -> String.to_atom(x) end) |> Enum.sort, String.graphemes(hand) |> Enum.map(fn x -> String.to_atom(x) end), String.to_integer(bid) } end)
  end
end

# IO.inspect(Day7.part1("day7_input.txt"))
IO.inspect(Day7.part2("day7_input.txt"))
