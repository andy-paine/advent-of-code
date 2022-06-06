FAV = STDIN.gets_to_end.strip.split("\n").first.to_i

def wall?(x, y) : Bool
  num = x*x + 3*x + 2*x*y + y + y*y + FAV
  num.to_s(2).chars.count(&.== '1') % 2 != 0
end

def adj(x, y)
  [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}].select { |a, b| a >= 0 && b >= 0 }
end

def path(x, y, path, points)
  points.push({x,y})
  return if path.size >= 50
  next_points = adj(x, y)
    .reject { |a, b| wall? a, b }
    .reject { |p| path.includes? p }

  next_points.each { |a, b| path(a, b, path + [{x, y}], points) }
end

points = [] of Tuple(Int32, Int32)
path(1, 1, [] of Tuple(Int32,Int32), points)
puts points.uniq.size
