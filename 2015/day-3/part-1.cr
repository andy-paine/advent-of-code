visited = STDIN.gets_to_end.strip.chars.reduce([{0, 0}]) do |visited, c|
  mx, my = {'^' => {0, 1}, 'v' => {0, -1}, '>' => {1, 0}, '<' => {-1, 0}}[c]
  visited.push({visited.last.first + mx, visited.last.last + my})
end
puts visited.uniq.size
