ExUnit.start

# No mix
# invoke with elixir -r day7.exs day7_test.exs

defmodule Day7Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day7.part1("day7_test_input.txt") == 6440
    end
  end

  describe "part2()" do
    test "Calculates the expected output" do
      assert Day7.part2("day7_test_input.txt") == 5905
    end
  end
end
