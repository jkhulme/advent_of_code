ExUnit.start

# No mix
# invoke with elixir -r day10.exs day10_test.exs

defmodule Day10Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the expected output" do
      assert Day10.part1("day10_test_input.txt") == 5
    end
  end

  # describe "part2()" do
  #   test "Calculates the expected output" do
  #     assert Day10.part2("day10_test_input.txt") == 2
  #   end
  # end
end
