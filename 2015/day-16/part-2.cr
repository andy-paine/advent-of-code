evidence = {
  "children"    => ->(n : Int32) { n == 3 },
  "cats"        => ->(n : Int32) { n > 7 },
  "samoyeds"    => ->(n : Int32) { n == 2 },
  "pomeranians" => ->(n : Int32) { n < 3 },
  "akitas"      => ->(n : Int32) { n == 0 },
  "vizslas"     => ->(n : Int32) { n == 0 },
  "goldfish"    => ->(n : Int32) { n < 5 },
  "trees"       => ->(n : Int32) { n > 3 },
  "cars"        => ->(n : Int32) { n == 2 },
  "perfumes"    => ->(n : Int32) { n == 1 },
}

sues = STDIN.gets_to_end.strip
  .split("\n")
  .compact_map { |l| /Sue \d+: (.*)/.match(l) }
  .compact_map(&.captures[0])
  .compact_map { |l| l.scan(/(\w+): (\d+)/).map { |ks| {ks[1], ks[2]} } }
  .map(&.to_h)

puts sues
  .each
  .with_index
  .select { |sue, i| sue.each.all? { |k, v| evidence[k].call v.to_i } }
  .map(&.last)
  .first + 1
