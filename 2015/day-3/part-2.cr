visited = STDIN.gets_to_end.strip.chars.each.with_index.reduce({[{0, 0}], [{0,0}]}) do |(v1, v2), (c, i)|
  mx, my = {'^' => {0, 1}, 'v' => {0, -1}, '>' => {1, 0}, '<' => {-1, 0}}[c]
  l = i%2==0 ? v1 : v2
  l.push({l.last.first + mx, l.last.last + my})
  {v1,v2}
end
puts visited.sum.uniq.size
