ExUnit.start

# No mix
# invoke with elixir -r day11.exs day11_test.exs

defmodule Day11Test do
  use ExUnit.Case

  describe "part1()" do
    test "Finds the level of monkey business" do
      assert Day11.part1("day11_test_input.txt") == 10605
    end
  end

  describe "part2()" do
    test "Finds the level of monkey business" do
      assert Day11.part2("day11_test_input.txt") == 2713310153
    end
  end
end
