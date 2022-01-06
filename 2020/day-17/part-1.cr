alias Point = Tuple(Int32, Int32, Int32)

def adj(x, y, z)
  (-1..1).map { |i| (-1..1).map { |j| (-1..1).map { |k| {x + i, y + j, z + k} } } }.flatten.reject({x, y, z})
end

def min(grid)
  Point.from((0..2).map { |i| grid.keys.min_by(&.[i])[i] })
end

def max(grid)
  Point.from((0..2).map { |i| grid.keys.max_by(&.[i])[i] })
end

grid = Hash(Point, Bool).new(false)
STDIN.gets_to_end.strip.split("\n").each_with_index { |x, i| x.chars.each_with_index { |y, j| grid[{i, j, 0}] = y == '#' } }

6.times do
  ngrid = grid.dup
  grid_min = min(grid)
  grid_max = max(grid)
  (grid_min[0] - 1..grid_max[0] + 1).each do |x|
    (grid_min[1] - 1..grid_max[1] + 1).each do |y|
      (grid_min[2] - 1..grid_max[2] + 1).each do |z|
        p = {x, y, z}
        adjs = adj(*p)
        cnt = adjs.count { |a| grid.fetch(a, false) }
        if grid.fetch(p, false)
          ngrid[p] = [2, 3].includes? cnt
        else
          ngrid[p] = cnt == 3
        end
      end
    end
  end
  grid = ngrid
end

puts grid.values.count(&.itself)
