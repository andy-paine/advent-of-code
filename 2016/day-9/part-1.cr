regex = /(\(\d+x\d+)\)/
result = (1..).reduce({"", STDIN.gets_to_end.strip}) do |(res,rem),_|
  break res + rem unless rem.matches? regex
	bef, comp, after = rem.partition regex
  chars, repeat = comp.strip("()").split('x').map(&.to_i)
  {res + bef + after[...chars]*repeat, after[chars..]}
end

puts result.size
