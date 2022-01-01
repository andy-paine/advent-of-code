triangles = STDIN.gets_to_end.strip.split("\n").in_groups_of(3).map do |grp|
  nums = grp.map(&.not_nil!.split.map(&.to_i))
  (0..2).map {|i| Tuple(Int32,Int32,Int32).from [nums[0][i], nums[1][i], nums[2][i]].sort}
end.flatten

puts triangles.count{|t| t.first(2).sum > t.last}
