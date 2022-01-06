alias Point = Tuple(Int32, Int32, Int32, Int32)

def adj(x, y, z, w)
  (-1..1).map { |i| (-1..1).map { |j| (-1..1).map { |k| (-1..1).map { |l| {x + i, y + j, z + k, w + l} } } } }.flatten.reject({x, y, z, w})
end

def min(grid)
  Point.from((0..3).map { |i| grid.keys.min_by(&.[i])[i] })
end

def max(grid)
  Point.from((0..3).map { |i| grid.keys.max_by(&.[i])[i] })
end

grid = Hash(Point, Bool).new(false)
STDIN.gets_to_end.strip.split("\n").each_with_index { |x, i| x.chars.each_with_index { |y, j| grid[{i, j, 0, 0}] = y == '#' } }

6.times do
  ngrid = grid.dup
  grid_min = min(grid)
  grid_max = max(grid)
  (grid_min[0] - 1..grid_max[0] + 1).each do |x|
    (grid_min[1] - 1..grid_max[1] + 1).each do |y|
      (grid_min[2] - 1..grid_max[2] + 1).each do |z|
        (grid_min[3] - 1..grid_max[3] + 1).each do |w|
          p = {x, y, z, w}
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
  end
  grid = ngrid
end

puts grid.values.count(&.itself)
