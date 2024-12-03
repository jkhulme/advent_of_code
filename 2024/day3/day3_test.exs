ExUnit.start

# No mix
# invoke with elixir -r day3.exs day3_test.exs

defmodule Day3Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day3.part1("day3_test_input.txt") == 161
    end
  end

  describe "part2()" do
    test "Calculates the answer to part 2" do
      assert Day3.part2("day3_test_input_part2.txt") == 48
    end
  end
end
