input = STDIN.gets_to_end.strip
puts input.scan(/-?\d+/).reduce(0){ |sum,match| sum + match[0].to_i}
