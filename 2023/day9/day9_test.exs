ExUnit.start

# No mix
# invoke with elixir -r day9.exs day9_test.exs

defmodule Day9Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day9.part1("day9_test_input.txt") == 114
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day9.part2("day9_test_input.txt") == 2
    end
  end
end
