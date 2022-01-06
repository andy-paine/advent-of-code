REGEX = /(\(\d+x\d+)\)/

def count(s)
  return s.size.to_i64 unless s.matches? REGEX
  bef, comp, after = s.partition REGEX
  chars, repeat = comp.strip("()").split('x').map(&.to_i)
  return bef.size.to_i64 + count(after[...chars])*repeat + count(after[chars..])
end

puts count(STDIN.gets_to_end.strip)
