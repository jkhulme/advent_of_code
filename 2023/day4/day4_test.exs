ExUnit.start

# No mix
# invoke with elixir -r day4.exs day4_test.exs

defmodule Day3Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day4.part1("day4_test_input.txt") == 13
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day4.part2("day4_test_input.txt") == 30
    end
  end
end
