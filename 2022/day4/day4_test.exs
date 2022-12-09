ExUnit.start

# No mix
# invoke with elixir -r day4.exs day4_test.exs

defmodule Day4Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the number of fully overlapping pairs" do
      assert Day4.part1("day4_test_input.txt") == 2
    end
  end

  describe "part2()" do
    test "It calculates number of pairs with any overlap" do
      assert Day4.part2("day4_test_input.txt") == 4
    end
  end
end
