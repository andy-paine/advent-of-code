tallies = STDIN.gets_to_end.strip.chars.tally
puts tallies['('] - tallies[')']
