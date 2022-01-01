def move(pos, dir)
  vec = {'U' => {-1, 0}, 'D' => {1, 0}, 'L' => {0, -1}, 'R' => {0, 1}}[dir]
  {Math.min(Math.max(pos[0] + vec[0], 0), 2), Math.min(Math.max(pos[1] + vec[1], 0), 2)}
end

keys = STDIN.gets_to_end.strip.split("\n").reduce([{1,1}]) do |keys,line|
  keys.push line.chars.reduce(keys.last) {|pos,dir| move(pos, dir)}
end[1..]

puts keys.map{|i,j| i*3 + j + 1}.join
