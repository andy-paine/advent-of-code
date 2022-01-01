directions = [{0,1},{1,0},{0,-1},{-1,0}]
instructions = STDIN.gets_to_end.strip.split(", ").map{|x| {x.chars.first, x.chars[1..].join.to_i}}
position = instructions.reduce([{0,0}]) do |pos,(d,mag)|
  vec = directions.rotate!(d == 'R' ? 1 : -1).first
  pos.concat (1..mag).map{|i| {pos.last[0] + vec[0]*i, pos.last[1] + vec[1]*i}}
end
puts position.tally.find{|_,v| v==2}.not_nil!.first.map(&.abs).sum
