ExUnit.start

# No mix
# invoke with elixir -r day8.exs day8_test.exs

defmodule Day8Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day8.part1("day8_test_input.txt") == 14
    end
  end

  describe "part2()" do
    test "Calculates the answer to part 2" do
      assert Day8.part2("day8_test_input.txt") == 34
    end
  end
end
