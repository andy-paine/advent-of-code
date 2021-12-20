puts STDIN.gets_to_end.strip.split("\n")
  .map(&.chars)
  .select { |cs| cs.count { |c| "aeiou".chars.includes? c } >= 3 }
  .select { |cs| cs.each.cons_pair.any? { |a, b| a == b } }
  .reject { |cs| ["ab", "cd", "pq", "xy"].any? { |s| cs.join.includes? s } }
  .size
