ExUnit.start

# No mix
# invoke with elixir -r day6.exs day6_test.exs

defmodule Day6Test do
  use ExUnit.Case

  describe "part1()" do
    test "It finds the packet start marker position" do
      assert Day6.part1("day6_test_input.txt") == 7
    end
  end

  describe "part2()" do
    test "It finds the packet start marker position" do
      assert Day6.part2("day6_test_input.txt") == 19
    end
  end
end
