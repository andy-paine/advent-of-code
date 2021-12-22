CONTAINERS = STDIN.gets_to_end.strip.split("\n").map(&.to_i)

alias Way = Array(Int32)
solutions = Hash(Int32, Set(Way)).new(Set(Way).new)

def ways(rem_containers : Array(Int32), remaining : Int32, solutions) : Array(Way)
  existing = solutions[remaining].select { |s| s.all? { |x| rem_containers.includes? x } }
  return existing unless existing.empty?
  sols = [] of Way
  rem_containers.select { |c| CONTAINERS[c] <= remaining }.each do |c|
    sols += [[c]] if remaining == CONTAINERS[c]
    ws = ways(rem_containers.reject(c), remaining - CONTAINERS[c], solutions)
    sols += ws.map { |f| [c] + f }
  end
  solutions[remaining] += Set(Way).new(sols)
  sols
end

puts ways((0...CONTAINERS.size).to_a, 150, solutions).map(&.sort).uniq.size

