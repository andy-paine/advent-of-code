alias Points = Set(Tuple(Int32,Int32))
ins = STDIN.gets_to_end.strip
  .split("\n")
  .map { |l| /(.*) (\d+),(\d+) through (\d+),(\d+)/.match(l).not_nil!.captures }
  .map { |l| l.map(&.not_nil!) }

ops = {
 	"toggle"   => ->(on : Points, ps : Points) { on ^ ps },
  "turn on"  => ->(on : Points, ps : Points) { on + ps },
  "turn off" => ->(on : Points, ps : Points) { on - ps },
}

def points(x1, y1, x2, y2) : Points
  (x1.to_i..x2.to_i).map { |x| (y1.to_i..y2.to_i).map { |y| {x, y} } }.flatten.to_set
end

on = Points.new
on = ins.reduce(on) do |on, (op, x1, y1, x2, y2)|
  ops[op].call(on, points(x1, y1, x2, y2))
end
puts on.size
