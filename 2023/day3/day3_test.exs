ExUnit.start

# No mix
# invoke with elixir -r day3.exs day3_test.exs

defmodule Day3Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the missing part numbers" do
      assert Day3.part1("day3_test_input.txt") == 4361
    end
  end

  describe "part2()" do
    test "Calculates the total of the top 3 most elves" do
      assert Day3.part2("day3_test_input.txt") == 467835
    end
  end
end
