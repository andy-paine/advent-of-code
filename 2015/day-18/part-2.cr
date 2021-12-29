lights = STDIN.gets_to_end.strip.split("\n")
  .map { |l| l.chars.map(&.== '#') }
max = lights.size

def adj(x, y, max)
  (x - 1..x + 1).map { |i| (y - 1..y + 1).map { |j| {i, j} } }
    .flatten
    .select { |i, j| (max-1 >= i >= 0) && (max-1 >= j >= 0) }
  .reject {|p| p == {x,y}}
end

def state(curr, on)
  return [2,3].includes? on if curr
  on == 3
end

def stuck(grid)
  grid[0][0] = true
  grid[0][-1] = true
  grid[-1][0] = true
  grid[-1][-1] = true
  grid
end

lights = 100.times.reduce(lights) do |lights|
  output = Array(Array(Bool)).new(max) {Array(Bool).new(max, false)}
  lights = stuck(lights)
  max.times do |x|
  	max.times do |y|
      on = adj(x,y,max).map{|i,j| lights[i][j]}.count(&.itself)
      output[x][y] = state(lights[x][y], on)
    end
  end
  output
end
puts stuck(lights).flatten.count(&.itself)
