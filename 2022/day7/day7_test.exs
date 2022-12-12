ExUnit.start

# No mix
# invoke with elixir -r day7.exs day7_test.exs

defmodule Day7Test do
  use ExUnit.Case

  describe "part1()" do
    test "It finds the sum of the sizes of the directories under 10MB" do
      assert Day7.part1("day7_test_input.txt") == 95437
    end
  end

  describe "part2()" do
    test "It finds the smallest directory to delete" do
      assert Day7.part2("day7_test_input.txt") == 24933642
    end
  end
end
