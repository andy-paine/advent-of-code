alias Points = Set(Tuple(Int32,Int32))

def points(x1, y1, x2, y2) : Points
  (x1..x2).map { |x| (y1..y2).map { |y| {x.to_i, y.to_i} } }.flatten.to_set
end

puts points("774","14","977","877").size
