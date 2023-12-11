ExUnit.start

# No mix
# invoke with elixir -r day8.exs day8_test.exs

defmodule Day8Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day8.part1("day8_test_input.txt") == 2
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day8.part2("day8_test_input2.txt") == 6
    end
  end
end
