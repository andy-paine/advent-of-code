def aba?(chars)
  chars[0] == chars[2] && chars[0] != chars[1]
end

valid = STDIN.gets_to_end.strip.split("\n").count do |ip|
  hypernets = ip.scan(/\[([a-z]+)\]/).compact_map(&.captures.first)
  supernets = ip.scan(/([a-z]+)/).compact_map(&.captures.first) - hypernets
  abas = supernets.flat_map{|s| s.chars.each_cons(3).select{|cs| aba? cs}.map(&.join).to_a}.reject(&.empty?)
  abas.any?{|aba| hypernets.any?(&.includes? [aba[1],aba[0],aba[1]].join)}
end

puts valid
