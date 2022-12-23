ExUnit.start

# No mix
# invoke with elixir -r day14.exs day14_test.exs

defmodule Day14Test do
  use ExUnit.Case

  describe "part1()" do
    test "Finds the amount of sand that comes to rest" do
      assert Day14.part1("day14_test_input.txt") == 24
    end
  end

  describe "part2()" do
    test "Finds the amount of sand needed to reach the start point" do
      assert Day14.part2("day14_test_input.txt") == 93
    end
  end
end
