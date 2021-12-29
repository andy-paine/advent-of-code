reps, molecule = STDIN.gets_to_end.strip.split("\n\n")
reps = reps
  .split("\n")
  .map { |r| r.split(" => ") }
  .group_by(&.first)
  .map { |k, v| {k, v.map(&.last)} }
  .to_h

atoms = molecule
  .chars
  .each
  .with_index
  .slice_when { |(a, _), (b, _)| b.uppercase? }
  .map { |chunk| {chunk.min_of(&.last), chunk.map(&.first).join} }

molecules = atoms.reduce(Set(String).new) do |molecules, (i, atom)|
  molecules + Set.new(reps.fetch(atom, [] of String).map { |r| molecule.sub i...i + atom.size, r })
end
puts molecules.size
