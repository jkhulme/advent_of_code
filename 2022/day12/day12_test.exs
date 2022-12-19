ExUnit.start

# No mix
# invoke with elixir -r day12.exs day12_test.exs

defmodule Day12Test do
  use ExUnit.Case

  describe "part1()" do
    test "Finds the shortest path" do
      assert Day12.part1("day12_test_input.txt") == 31
    end
  end

  describe "part2()" do
    test "Finds the shortest path from any start point" do
      assert Day12.part2("day12_test_input.txt") == 29
    end
  end
end
