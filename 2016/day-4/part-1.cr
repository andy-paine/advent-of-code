real_rooms = STDIN
  .gets_to_end
  .strip
  .split("\n")
  .compact_map { |l| /([a-z-]+)-(\d+)\[([a-z]{5})\]/.match l }
  .map { |m| {m[1].delete('-'), m[2].to_i, m[3]} }
  .select do |room|
    room.last == room.first.chars.sort.tally.to_a.sort_by { |_, v| -1*v }.map(&.first).first(5).join
  end

puts real_rooms.map(&.[1]).sum
