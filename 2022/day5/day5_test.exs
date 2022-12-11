ExUnit.start

# No mix
# invoke with elixir -r day5.exs day5_test.exs

defmodule Day5Test do
  use ExUnit.Case

  describe "part1()" do
    test "It puts the correct crates on top" do
      assert Day5.part1("day5_test_input.txt") == "CMZ"
    end
  end

  describe "part2()" do
    test "It puts the correct crates on top" do
      assert Day5.part2("day5_test_input.txt") == "MCD"
    end
  end
end
