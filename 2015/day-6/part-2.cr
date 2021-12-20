ins = STDIN.gets_to_end.strip
  .split("\n")
  .map { |l| /(.*) (\d+),(\d+) through (\d+),(\d+)/.match(l).not_nil!.captures }
  .map { |l| l.map(&.not_nil!) }

ops = {
  "toggle"   => ->(i : Int32) { i + 2 },
  "turn on"  => ->(i : Int32) { i + 1 },
  "turn off" => ->(i : Int32) { Math.max(i - 1, 0) },
}

def points(x1, y1, x2, y2)
  (x1.to_i..x2.to_i).map { |x| (y1.to_i..y2.to_i).map { |y| {x, y} } }.flatten
end

lights = Array(Array(Int32)).new(1000) { |_| Array(Int32).new(1000, 0) }
lights = ins.reduce(lights) do |lights, (op, x1, y1, x2, y2)|
  points(x1, y1, x2, y2).each do |x, y|
    lights[x][y] = ops[op].call(lights[x][y])
  end
  lights
end
puts lights.flatten.sum
