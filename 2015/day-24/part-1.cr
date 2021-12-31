nums = STDIN.gets_to_end.strip.split("\n").map(&.to_i)
target = (nums.sum/3).to_i

def weights(nums : Array(Int32), target : Int32) : Array(Array(Int32))
  combos = (1..).map do |i|
    cs = nums.combinations(i).select{|ns| ns.sum == target}
		break cs unless cs.empty?
  end
  combos.empty? ? [] of Array(Int32) : combos.as(Array(Array(Int32)))
end

passenger = weights(nums, target).select do |cs|
  weights(nums - cs, target)
end.first
puts passenger.map(&.to_i64).product
