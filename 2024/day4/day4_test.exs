ExUnit.start

# No mix
# invoke with elixir -r day4.exs day4_test.exs

defmodule Day4Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day4.part1("day4_test_input.txt") == 18
    end
  end

  describe "part2()" do
    test "Calculates the answer to part 2" do
      assert Day4.part2("day4_test_input.txt") == 9
    end
  end
end
