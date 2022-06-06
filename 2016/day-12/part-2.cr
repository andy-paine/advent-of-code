alias Op = Proc(Hash(String, Int32), Array(String), Int32)
OPS = {
  "cpy" => Op.new {|regs,args| regs[args[1]] = args[0].to_i? ? args[0].to_i : regs[args[0]]; 1},
  "inc" => Op.new {|regs,args| regs[args[0]] += 1; 1 },
  "dec" => Op.new {|regs,args| regs[args[0]] -= 1; 1 },
  "jnz" => Op.new {|regs,args| (args[0].to_i? ? args[0].to_i : regs[args[0]]).zero? ? 1 : args[1].to_i},
}

regs = "abd".chars.map{|c| {c.to_s,0}}.to_h.merge({"c" => 1})
instructions = STDIN.gets_to_end.strip.split("\n").map(&.split)
i = 0
until i >= instructions.size
  i += OPS[instructions[i][0]].call(regs, instructions[i][1..])
end
puts regs["a"]
