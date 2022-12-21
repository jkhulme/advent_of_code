ExUnit.start

# No mix
# invoke with elixir -r day13.exs day13_test.exs

defmodule Day13Test do
  use ExUnit.Case

  describe "part1()" do
    test "Finds the sum of the indices of the correct pairs" do
      assert Day13.part1("day13_test_input.txt") == 13
    end

    test "can compare basic arrays" do
      assert Day13.compare([1,1,3,1,1], [1,1,5,1,1]) == [nil, nil, true, nil, nil]
      assert Day13.compare([1,1,5,1,1], [1,1,3,1,1]) == [nil, nil, false, nil, nil]
    end

    test "can compare nested arrays" do
      assert Day13.compare([[1]], [[1]]) == [nil]
      assert Day13.compare([[1]], [[3]]) == [true]
      assert Day13.compare([[5]], [[4]]) == [false]
    end

    test "can compare array and number" do
      assert Day13.compare([2, 3, 4], 4) == [true, false]
    end
  end

  describe "part2()" do
    test "Finds the decoder key" do
      assert Day13.part2("day13_test_input.txt") == 140
    end
  end
end
