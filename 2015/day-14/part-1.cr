record Reindeer, name : String, speed : Int32, fly_time : Int32, rest_time : Int32

reindeer = STDIN.gets_to_end.strip.split("\n")
  .compact_map { |l| /(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds./.match l }
  .map { |r| Reindeer.new r[1], r[2].to_i, r[3].to_i, r[4].to_i }

positions = reindeer.map { |r| {r, 0} }.to_h
2503.times do |sec|
  reindeer.each do |r|
    positions[r] += r.speed if sec % (r.fly_time + r.rest_time) < r.fly_time
  end
end
puts positions.values.max
