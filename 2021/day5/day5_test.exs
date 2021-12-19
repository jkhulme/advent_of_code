ExUnit.start

# No mix
# invoke with elixir -r day5.exs day5_test.exs

defmodule Day5Test do
  use ExUnit.Case

  describe "part1()" do
    test "Calculates number of points where horizontal and vertical lines overlap" do
      assert Day5.part1("day5_test_input.txt") == 5
    end
  end

  describe "part2()" do
    test "Calculates number of points where horizontal, vertical, and diagonal lines overlap" do
      assert Day5.part2("day5_test_input.txt") == 12
    end
  end

  describe "Interpolating diagonal lines" do
    test "[{6, 4}, {2, 0}]" do
      assert Day5.interpolate_all([{6, 4}, {2, 0}]) == [{6, 4}, {5, 3}, {4, 2}, {3, 1}, {2, 0}]
    end

    test "[{8, 0}, {0, 8}]" do
      assert Day5.interpolate_all([{8, 0}, {0, 8}]) == [{8, 0}, {7, 1}, {6, 2}, {5, 3}, {4, 4}, {3, 5}, {2, 6}, {1, 7}, {0, 8}]
    end
  end
end
