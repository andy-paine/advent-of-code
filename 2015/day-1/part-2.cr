index = STDIN.gets_to_end.strip.chars.each.with_index.reduce(0) do |t,(c,i)|
  t += (c == '(' ? 1 : -1)
  break i+1 if t < 0
  t
end
puts index
