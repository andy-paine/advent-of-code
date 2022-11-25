INPUT = STDIN.gets_to_end.strip.lines
  .map { |s| /Disc #(\d+) has (\d+) positions; at time=0, it is at position (\d+)./.match(s).not_nil! }
  .map { |md| {num: md[1].to_i, slots: md[2].to_i, init_pos: md[3].to_i} }

INPUT << {num: INPUT.last[:num]+1, slots: 11, init_pos: 0}

puts (1..).each.select { |t| INPUT.all? { |disc| (t + disc[:num] + disc[:init_pos]) % disc[:slots] == 0 } }.first
