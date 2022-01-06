puts STDIN.gets_to_end.strip.split("\n").map(&.chars).transpose.map(&.tally.to_a.sort_by(&.last).last.first).join
