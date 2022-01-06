minute, buses = STDIN.gets_to_end.strip.split "\n"
buses = buses.split(",").select(&.to_i?).map(&.to_i)
minute = minute.to_i
min = (minute..).find { |m| !buses.find { |b| m % b == 0 }.nil? }.not_nil!
puts buses.find { |b| min % b == 0 }.not_nil! * (min - minute)
