ExUnit.start

# No mix
# invoke with elixir -r day2.exs day2_test.exs

defmodule Day2Test do
  use ExUnit.Case

  describe "part1()" do
    test "It calculates the highest calories a single elf has" do
      assert Day2.part1("day2_test_input.txt") == 8
    end
  end

  # describe "part2()" do
  #   test "Calculates the total of the top 3 most elves" do
  #     assert Day1.part2("day1_test_input_part2.txt") == 281
  #   end
  # end
end
