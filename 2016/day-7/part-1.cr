def abba?(chars)
  chars[0] == chars[3] && chars[1] == chars[2] && chars[0] != chars[1]
end

valid = STDIN.gets_to_end.strip.split("\n").count do |ip|
  next false if ip.scan(/\[([a-z]+)\]/).compact_map(&.captures.first).any?{|b| b.chars.each_cons(4).any?{|cs| abba?(cs)}}
  ip.scan(/([a-z]+)/).compact_map(&.captures.first).any?{|b| b.chars.each_cons(4).any?{|cs| abba?(cs)}}
end
puts valid
