lines = STDIN.gets_to_end.strip.split("\n")
total = lines.reduce(0) do |total,l|
  total + l.inspect.size - l.size
end
puts total
