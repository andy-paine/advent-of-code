puts STDIN.gets_to_end.strip
	.split("\n")
	.map{|l| l.split("x").map(&.to_i)}
	.map{|b| b.sort.first(2).sum * 2 + b.product}
  .sum
