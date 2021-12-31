row, column = STDIN.gets_to_end.strip.scan(/(\d+)/).map(&.[0].to_i)
count = (1..column + row - 1).sum - row + 1
puts (count-1).times.reduce(20151125.to_i64){ |num| (num * 252533) % 33554393}
