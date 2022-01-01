puts STDIN.gets_to_end.strip.split("\n").map(&.split.map(&.to_i).sort).count{|t| t.first(2).sum > t.last}
