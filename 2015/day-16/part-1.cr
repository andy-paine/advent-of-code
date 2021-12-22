evidence = "children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1".split("\n").map(&.split ": ").to_h

sues = STDIN.gets_to_end.strip
  .split("\n")
  .compact_map { |l| /Sue \d+: (.*)/.match(l) }
  .compact_map(&.captures[0])
  .compact_map { |l| l.scan(/(\w+): (\d+)/).map { |ks| {ks[1], ks[2]} } }
  .map(&.to_h)

puts sues
  .each
  .with_index
  .select { |sue, i| sue.each.all? { |k, v| evidence[k] == v } }
  .map(&.last)
  .first + 1
