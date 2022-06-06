INPUT = STDIN.gets_to_end.strip.split("\n")
FAV   = INPUT.first.to_i
DEST  = Tuple(Int32, Int32).from(INPUT.last.split(",").map(&.to_i))

def wall?(x, y) : Bool
  num = x*x + 3*x + 2*x*y + y + y*y + FAV
  num.to_s(2).chars.count(&.== '1') % 2 != 0
end

def adj(x, y)
  [{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}].select { |a, b| a >= 0 && b >= 0 }
end

def path(x, y, path, shortest : Pointer(Int32))
  return if path.size > shortest.value
  shortest.value = path.size if {x, y} == DEST
  adj(x, y)
    .reject { |a, b| wall? a, b }
    .reject { |p| path.includes? p }
    .each { |a, b| path(a, b, path + [{x, y}], shortest) }
end

shortest = Int32::MAX
path(1, 1, [] of Tuple(Int32, Int32), pointerof(shortest))
puts shortest
