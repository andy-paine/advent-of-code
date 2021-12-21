lines = STDIN.gets_to_end.strip.split("\n")
total = lines.reduce(0) do |total, l|
  total + l.size - `crystal eval 'puts #{l}.size'`.to_i
end
puts total
