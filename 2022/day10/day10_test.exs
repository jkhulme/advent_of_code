ExUnit.start

# No mix
# invoke with elixir -r day10.exs day10_test.exs

defmodule Day10Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the sum of the six signal strengths?" do
      assert Day10.part1("day10_test_input.txt") == 13140
    end
  end
end
