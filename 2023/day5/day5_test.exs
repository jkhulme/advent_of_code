ExUnit.start

# No mix
# invoke with elixir -r day5.exs day5_test.exs

defmodule Day5Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day5.part1("day5_test_input.txt") == 35
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day5.part2("day5_test_input.txt") == 46
    end
  end
end
