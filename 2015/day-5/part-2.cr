nice = STDIN.gets_to_end.strip.split("\n")
  .select do |s|
    pairs = s.chars.each.cons_pair.map(&.join).uniq
    pairs.any? { |p| s.scan(p).size > 1 }
  end.select do |s|
  s.chars.each.cons(3).any? { |(a, _, c)| a == c }
end
puts nice.size
