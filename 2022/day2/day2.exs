defmodule Day2 do
  def part1(input_path) do
    parseInput(input_path) |> scoreRounds(&scoreRound1/2)
  end

  def part2(input_path) do
    parseInput(input_path) |> scoreRounds(&scoreRound2/2)
  end

  defp scoreRounds([[opp, me] | rs], scoreFunc) do
    scoreFunc.(opp, me) + scoreRounds(rs, scoreFunc)
  end
  defp scoreRounds([], _) do
    0
  end

  defp scoreRound1(opp, me) do
    %{
      A: %{
        X: 3 + 1,
        Y: 6 + 2,
        Z: 0 + 3
      },
      B: %{
        X: 0 + 1,
        Y: 3 + 2,
        Z: 6 + 3
      },
      C: %{
        X: 6 + 1,
        Y: 0 + 2,
        Z: 3 + 3,
      }
    }[String.to_atom(opp)][String.to_atom(me)]
  end

  defp scoreRound2(opp, me) do
    %{
      A: %{
        X: 0 + 3,
        Y: 3 + 1,
        Z: 6 + 2
      },
      B: %{
        X: 0 + 1,
        Y: 3 + 2,
        Z: 6 + 3
      },
      C: %{
        X: 0 + 2,
        Y: 3 + 3,
        Z: 6 + 1,
      }
    }[String.to_atom(opp)][String.to_atom(me)]
  end
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.trim() |> String.split("\n") |> Enum.map(fn x -> String.trim(x) |> String.split(" ") end)
  end
end

IO.puts(Day2.part1("day2_input.txt"))
IO.puts(Day2.part2("day2_input.txt"))
