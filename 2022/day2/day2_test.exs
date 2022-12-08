ExUnit.start

# No mix
# invoke with elixir -r day2.exs day2_test.exs

defmodule Day2Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the winning strategy score" do
      assert Day2.part1("day2_test_input.txt") == 15
    end
  end

  describe "part2()" do
    test "It calculates the winning strategy score" do
      assert Day2.part2("day2_test_input.txt") == 12
    end
  end
end
