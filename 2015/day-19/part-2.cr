reps, molecule = STDIN.gets_to_end.strip.split("\n\n")
reps = reps
  .split("\n")
  .map { |r| r.split(" => ") }
  .map(&.reverse)
  .to_h

reps_keys = reps.keys.sort_by(&.size).reverse
iterations = (1..).find do |i|
  replacement = reps_keys.find{|k| molecule.includes? k}.not_nil!
	molecule = molecule.sub replacement, reps[replacement]
	molecule == "e"
end
puts iterations
