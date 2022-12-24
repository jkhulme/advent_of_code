ExUnit.start

# No mix
# invoke with elixir -r day15.exs day15_test.exs

defmodule Day15Test do
  use ExUnit.Case

  describe "part1()" do
    test "Finds the correct amount of places that cant have a sensor" do
      assert Day15.part1("day15_test_input.txt", 10) == 26
    end
  end

  describe "part2()" do
    test "Finds the frequency of the distress beacon" do
      assert Day15.part2("day15_test_input.txt", 20) == 56000011
    end
  end
end
