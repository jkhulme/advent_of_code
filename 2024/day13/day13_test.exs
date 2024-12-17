ExUnit.start

# No mix
# invoke with elixir -r day13.exs day13_test.exs

defmodule Day13Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day13.part1("day13_test_input.txt") == 480
    end
  end

  # describe "part2()" do
  #   test "Calculates the answer to part 2" do
  #     assert Day13.part2("day13_test_input.txt") == 81
  #   end
  # end
end
