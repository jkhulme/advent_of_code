ExUnit.start

# No mix
# invoke with elixir -r day9.exs day9_test.exs

defmodule Day9Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day9.part1("day9_test_input.txt") == 1928
    end
  end

  describe "part2()" do
    test "Calculates the answer to part 2" do
      assert Day9.part2("day9_test_input.txt") == 2858
    end
  end
end
