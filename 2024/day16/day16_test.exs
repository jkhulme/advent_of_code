ExUnit.start

# No mix
# invoke with elixir -r day16.exs day16_test.exs

defmodule Day16Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the answer to part 1" do
      assert Day16.part1("day16_test_input.txt") == 7036
    end
  end

  # describe "part2()" do
  #   test "Calculates the answer to part 2" do
  #     assert Day16.part2("day16_test_input.txt") == 81
  #   end
  # end
end
