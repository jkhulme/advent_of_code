ExUnit.start

# No mix
# invoke with elixir -r day14.exs day14_test.exs

defmodule Day14Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day14.part1("day14_test_input.txt", {11, 7}) == 12
    end
  end

  # describe "part2()" do
  #   test "Calculates the answer to part 2" do
  #     assert Day14.part2("day14_test_input.txt", {11, 7}) == 81
  #   end
  # end
end
