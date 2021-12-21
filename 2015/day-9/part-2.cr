routes = STDIN.gets_to_end.strip.split("\n").map do |l|
  m = /(.*) to (.*) = (\d+)/.match(l).not_nil!.captures.map(&.not_nil!)
  {[m[0],m[1]],m[2].to_i}
end.to_h

dists = routes.keys.flatten.uniq.permutations.compact_map do |perm|
  next unless perm.each.cons_pair.all? {|a,b| routes.has_key?([a,b]) || routes.has_key?([b,a])}
  perm.each.cons_pair.reduce(0){|t,(a,b)| t + routes.fetch([a,b], routes.fetch([b,a], 0)).not_nil!}
end
puts dists.max
