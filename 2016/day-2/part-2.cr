COORDS = 5.times.map {|i| (5-2*(i-2).abs).times.map {|j| {i,j+(i-2).abs}}}.flatten.to_a

def move(pos, dir)
  vec = {'U' => {-1, 0}, 'D' => {1, 0}, 'L' => {0, -1}, 'R' => {0, 1}}[dir]
  new_pos = {pos[0] + vec[0], pos[1] + vec[1]}
  (COORDS.includes? new_pos) ? new_pos : pos
end

keys = STDIN.gets_to_end.strip.split("\n").reduce([{2,0}]) do |keys,line|
  keys.push line.chars.reduce(keys.last) {|pos,dir| move(pos, dir)}
end[1..]

puts keys.compact_map{|k| COORDS.index k}.map{|k| (k+1).to_s 16}.join.upcase
