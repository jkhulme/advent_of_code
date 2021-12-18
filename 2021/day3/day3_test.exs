ExUnit.start

# No mix
# invoke with elixir -r day3.exs day3_test.exs

defmodule Day3Test do
  use ExUnit.Case

  describe "part1()" do
    test "Calculates the correct power consumption" do
      assert Day3.part1("day3_test_input.txt") == 198
    end
  end

  describe "part2()" do
    test "Calculates the correct life support rating" do
      assert Day3.part2("day3_test_input.txt") == 230
    end
  end
end
