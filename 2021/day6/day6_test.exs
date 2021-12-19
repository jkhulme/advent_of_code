ExUnit.start

# No mix
# invoke with elixir -r day6.exs day6_test.exs

defmodule Day6Test do
  use ExUnit.Case

  describe "part1()" do
    test "Calculate the correct number of fish" do
      assert Day6.part1("day6_test_input.txt") == 5934
    end
  end

  describe "part2()" do
    test "Calculate the correct number of fish" do
      assert Day6.part2("day6_test_input.txt") == 26984457539
    end
  end
end
