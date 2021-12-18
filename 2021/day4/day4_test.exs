ExUnit.start

# No mix
# invoke with elixir -r day4.exs day4_test.exs

defmodule Day4Test do
  use ExUnit.Case

  describe "part1()" do
    test "Finds the winning board" do
      assert Day4.part1("day4_test_input.txt") == 4512
    end
  end

  describe "part2()" do
    test "Finds the board that wins last" do
      assert Day4.part2("day4_test_input.txt") == 1924
    end
  end
end
