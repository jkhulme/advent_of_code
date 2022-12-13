ExUnit.start

# No mix
# invoke with elixir -r day8.exs day8_test.exs

defmodule Day8Test do
  use ExUnit.Case

  describe "part1()" do
    test "It counts the visible trees" do
      assert Day8.part1("day8_test_input.txt") == 21
    end
  end

  describe "part2()" do
    test "It finds the highest scenic score" do
      assert Day8.part2("day8_test_input.txt") == 8
    end
  end
end
