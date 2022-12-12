defmodule Day7 do
  def part1(input_path) do
    dir = parseInput(input_path) |> traverseDirectory(%{}, [])
    # Map.keys(dir) |> Enum.each(fn pwd -> printDir(dir, pwd) end)
    Map.keys(dir) |> Enum.map(fn d -> {d, dirSize(dir, d, 0)} end) |> Enum.reject(fn {_, s} -> s > 100000 end) |> Enum.map(fn {_, s} -> s end) |> Enum.sum
  end

  def part2(input_path) do
    dir = parseInput(input_path) |> traverseDirectory(%{}, [])
    # Map.keys(dir) |> Enum.each(fn pwd -> printDir(dir, pwd) end)
    spaceRequired = 30000000 - (70000000 - (Map.keys(dir) |> Enum.map(fn d -> {dirSize(dir, d, 0), d} end) |> Enum.max |> elem(0)))
    Map.keys(dir) |> Enum.map(fn d -> {dirSize(dir, d, 0), d} end) |> Enum.reject(fn {s, _} -> s < spaceRequired end) |> Enum.min |> elem(0)
  end

  defp printDir(dir, pwd) do
    IO.puts("current dir: #{pwd}")
    IO.puts("subdirs: #{Enum.join(dir[pwd][:childDirs], ", ")}")
    IO.puts("fileSize: #{dir[pwd][:fileBytes]}")
    IO.puts("parent: #{dir[pwd][:parent]}")

    IO.puts("--------------------------------------")
  end

  defp dirSize(dir, pwd, size) do
    dir[pwd][:fileBytes] + size + Enum.sum(Enum.map(dir[pwd][:childDirs], fn c -> dirSize(dir, c, 0) end))
  end

  defp traverseDirectory([], dir, _) do
    dir
  end
  defp traverseDirectory([[c | cs] | commands], dir, pwd) do
    cond do 
      c == "cd" ->
        if cs == [".."] do
          traverseDirectory(
            commands, 
            dir, 
            dir[Enum.join(pwd, "/")][:parent]
          )
        else
          traverseDirectory(
            commands, 
            Map.put(dir, Enum.join(pwd ++ cs, "/"), %{parent: pwd, fileBytes: 0, childDirs: []}), 
            pwd ++ cs
          )
        end
      c == "ls" ->
        traverseDirectory(commands, dir, pwd)
      c == "dir" ->
        traverseDirectory(
          commands, 
          Map.update!(dir, Enum.join(pwd, "/"), fn x -> Map.update!(x, :childDirs, fn d -> d ++ [Enum.join(pwd ++ cs, "/")] end) end), 
          pwd
        )
      true ->
        traverseDirectory(
          commands, 
          Map.update!(dir, Enum.join(pwd, "/"), fn x -> Map.update!(x, :fileBytes, fn b -> b + String.to_integer(c) end) end),
          pwd
        )
    end
  end
  
  defp parseInput(input_path) do
    File.read!(input_path) |> String.split("\r\n") |> Enum.map(fn x -> String.split(x, " ") |> cleanCommand end)
  end

  defp cleanCommand([c1 | cs]) do
    cond do
      c1 == "$" ->
        cs
      true ->
        [c1] ++ cs
    end
  end
end

IO.puts(Day7.part1("day7_input.txt"))
IO.puts(Day7.part2("day7_input.txt"))
