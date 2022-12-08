ExUnit.start

# No mix
# invoke with elixir -r day3.exs day3_test.exs

defmodule Day3Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the priority score of the luggage items" do
      assert Day3.part1("day3_test_input.txt") == 157
    end
  end

  describe "part2()" do
    test "It calculates the priority score of the elf groups" do
      assert Day3.part2("day3_test_input.txt") == 70
    end
  end
end
