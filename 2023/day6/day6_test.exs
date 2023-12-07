ExUnit.start

# No mix
# invoke with elixir -r day6.exs day6_test.exs

defmodule Day6Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day6.part1("day6_test_input.txt") == 288
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day6.part2("day6_test_input.txt") == 71503
    end
  end
end
