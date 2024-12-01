ExUnit.start

# No mix
# invoke with elixir -r day1.exs day1_test.exs

defmodule Day1Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the highest calories a single elf has" do
      assert Day1.part1("day1_test_input.txt") == 11
    end
  end

  describe "part2()" do
    test "Calculates the total of the top 3 most elves" do
      assert Day1.part2("day1_test_input.txt") == 31
    end
  end
end
