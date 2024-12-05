ExUnit.start

# No mix
# invoke with elixir -r day5.exs day5_test.exs

defmodule Day5Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day5.part1("day5_test_input.txt") == 143
    end
  end

  describe "part2()" do
    test "Calculates the answer to part 2" do
      assert Day5.part2("day5_test_input.txt") == 123
    end
  end
end
