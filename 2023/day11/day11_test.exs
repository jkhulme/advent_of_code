ExUnit.start

# No mix
# invoke with elixir -r day11.exs day11_test.exs

defmodule Day11Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day11.part1("day11_test_input.txt") == 374
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day11.part2("day11_test_input.txt") == 1030
    end
  end
end
