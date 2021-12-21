happy = STDIN.gets_to_end.strip.split("\n")
  .compact_map { |l| /(\w+) would (\w+) (\d+) happiness units by sitting next to (\w+)\./.match l }
  .map { |m| { {m[1], m[4]}, (m[2] == "lose" ? -1 : 1) * m[3].to_i } }
  .to_h

people = happy.keys.map { |a, b| [a, b] }.flatten.uniq
happinesses = people.permutations.map do |perm|
  perm.size.times.reduce(0) do |total|
    a, b = perm.rotate!.first(2)
    total + happy[{a, b}] + happy[{b, a}]
  end
end
puts happinesses.max
