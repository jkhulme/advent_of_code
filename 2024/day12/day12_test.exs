ExUnit.start

# No mix
# invoke with elixir -r day12.exs day12_test.exs

defmodule Day12Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day12.part1("day12_test_input.txt") == 1930
    end
  end

  # describe "part2()" do
  #   test "Calculates the answer to part 2" do
  #     assert Day12.part2("day12_test_input.txt") == 81
  #   end
  # end
end
