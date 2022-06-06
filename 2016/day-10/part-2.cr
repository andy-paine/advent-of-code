record Ins, low : String, high : String
values, ins = STDIN.gets_to_end.strip.split("\n").partition(&.includes? "value")

ins = ins
  .map { |i| i.scan(/(\w+ \d+)/).map(&.[0]) }
  .map { |(b, l, h)| {b, Ins.new(l, h)} }
  .to_h

slots = values
  .map { |v| Tuple(Int32, Int32).from(v.scan(/\d+/).map(&.[0].to_i)) }
  .group_by(&.last)
  .map { |k, v| {"bot #{k}", v.map(&.first)} }
  .to_h

until ins.empty?
  bot, vals = slots.find { |k, v| v.size == 2 && ins.has_key? k }.not_nil!
  slots[ins[bot].low] = slots.fetch(ins[bot].low, [] of Int32).push vals.min
  slots[ins[bot].high] = slots.fetch(ins[bot].high, [] of Int32).push vals.max
  ins.delete bot
end

puts (0..2).map{|i| slots["output #{i}"].first}.product
