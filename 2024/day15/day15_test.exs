ExUnit.start

# No mix
# invoke with elixir -r day15.exs day15_test.exs

defmodule Day15Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day15.part1("day15_test_input.txt") == 2028
    end
  end

  # describe "part2()" do
  #   test "Calculates the answer to part 2" do
  #     assert Day15.part2("day15_test_input.txt", {11, 7}) == 81
  #   end
  # end
end
