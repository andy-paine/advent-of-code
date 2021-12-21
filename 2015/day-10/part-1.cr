result = 40.times.reduce(STDIN.gets_to_end.strip) do |s|
  puts "#{Time.utc}: #{s.size}"
	s.chars.chunks(&.itself).reduce("") do |s,(c,cs)|
  	s + "#{cs.size}#{c}"
	end
end
puts result.size
