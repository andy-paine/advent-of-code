def area(l,w,h)
  a = [l*w, w*h, h*l]
  a.map(&.* 2).sum + a.min
end

puts STDIN.gets_to_end.strip
	.split("\n")
	.map{|l| Tuple(Int32,Int32,Int32).from(l.split("x").map(&.to_i))}
	.map{|b| area(*b)}.sum
