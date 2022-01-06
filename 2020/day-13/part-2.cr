buses = STDIN.gets_to_end.strip.split("\n").last
  .split(",")
  .each
  .with_index
  .select { |x, _| x.to_i64? }
  .map { |x, i| {x.to_i64, i} }
  .to_a

increment = buses.first.first
n = (1_i64..).find { |x| x % buses.first.first == buses.first.last }.not_nil!
buses.each_cons_pair do |(a, ai), (b, bi)|
  until n % b == (b - bi % b)
    n += increment
  end
  increment *= b
end
puts n
