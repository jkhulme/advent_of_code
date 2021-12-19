ExUnit.start

# No mix
# invoke with elixir -r day8.exs day8_test.exs

defmodule Day8Test do
  use ExUnit.Case

  describe "part1()" do
    test "Calculates the number of unique digits in the outputs" do
      assert Day8.part1("day8_test_input.txt") == 26
    end
  end

  describe "part2()" do
    test "Calculates the total of the outputs" do
      assert Day8.part2("day8_test_input.txt") == 61229
    end
  end
end
