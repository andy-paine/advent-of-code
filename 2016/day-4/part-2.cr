letters = "abcdefghijklmnopqrstuvwxyz".chars

real_rooms = STDIN
  .gets_to_end
  .strip
  .split("\n")
  .compact_map { |l| /([a-z-]+)-(\d+)\[([a-z]{5})\]/.match l }
  .map { |m| {m[1], m[2].to_i, m[3]} }
  .select do |room|
    room.last == room.first.chars.reject('-').sort.tally.to_a.sort_by { |_, v| -1*v }.map(&.first).first(5).join
  end

decoded = real_rooms.map do |room|
  {room.first.chars.map{|c| letters.includes?(c) ? letters[(letters.index(c).not_nil!+room[1])%letters.size] : ' '}.join, room[1]}
end

puts decoded.find{|k,_| k == "northpole object storage"}.not_nil!.last

