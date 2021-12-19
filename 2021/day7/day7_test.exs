ExUnit.start

# No mix
# invoke with elixir -r day7.exs day7_test.exs

defmodule Day7Test do
  use ExUnit.Case

  describe "part1()" do
    test "Calculates the minimum fuel" do
      assert Day7.part1("day7_test_input.txt") == 37
    end
  end

  describe "part2()" do
    test "Calculates the minimum fuel" do
      assert Day7.part2("day7_test_input.txt") == 168
    end
  end
end
