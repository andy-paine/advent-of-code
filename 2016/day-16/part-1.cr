INPUT = STDIN.gets_to_end.strip.chars.map(&.to_i)
LENGTH = 272

rounds = (Math.log2(LENGTH + 1) - Math.log2(INPUT.size) - 1).ceil.to_i
data = rounds.times.reduce(INPUT) {|a| a + [0] + a.reverse.map(&.^ 1) }.first(LENGTH)

def checksum(data)
  chk = data.each_slice(2).map{|(a,b)| a ^ b ^ 1}.to_a
  return chk if chk.size.odd?
  checksum(chk)
end

puts checksum(data).join
