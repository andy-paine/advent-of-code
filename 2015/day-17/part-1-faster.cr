CONTAINERS = STDIN.gets_to_end.strip.split("\n").map(&.to_i)

alias Way = Array(Int32)
solutions = Hash(Int32, Set(Way)).new(Set(Way).new)

def ways(rem_containers : Array(Int32), remaining : Int32, solutions) : Array(Way)
  sols = [] of Way
  rem_containers.select { |c| CONTAINERS[c] <= remaining }.each do |c|
    sols += [[c]] if remaining == CONTAINERS[c]
    existing = solutions[remaining - CONTAINERS[c]].select { |s| s.all? { |x| rem_containers.reject(c).includes? x } }
    ws = unless existing.empty?
      existing
    else
      w = ways(rem_containers.reject(c), remaining - CONTAINERS[c], solutions)
      solutions[remaining - CONTAINERS[c]] += Set(Way).new(w.map(&.sort))
      w
    end
    sols += ws.map { |f| [c] + f }
  end
  sols
end

puts ways((0...CONTAINERS.size).to_a, 150, solutions).map(&.sort).uniq.size
