ExUnit.start

# No mix
# invoke with elixir -r day9.exs day9_test.exs

defmodule Day9Test do
  use ExUnit.Case

  describe "part1()" do
    test "It counts the positions the tail visits" do
      assert Day9.part1("day9_test_input.txt") == 13
    end
  end

  describe "part2()" do
    test "It counts the position the tail visits - small" do
      assert Day9.part2("day9_test_input.txt") == 1
    end

    test "It counts the position the tail visits - large" do
      assert Day9.part2("day9_test_input2.txt") == 36
    end
  end
end
