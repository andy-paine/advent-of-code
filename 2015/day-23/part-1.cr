alias Ins = Proc(Hash(String, Int32), Array(String), Int32)
instructions = {
  "hlf" => Ins.new{|regs,vars| regs[vars.first] = (regs[vars.first]/2).to_i; 1},
  "tpl" => Ins.new{|regs,vars| regs[vars.first] *= 3; 1},
  "inc" => Ins.new{|regs,vars| regs[vars.first] += 1; 1},
  "jmp" => Ins.new{|_,vars| vars.first.to_i},
  "jie" => Ins.new{|regs,vars| regs[vars.first] % 2 == 0 ? vars.last.to_i : 1},
  "jio" => Ins.new{|regs,vars| regs[vars.first] == 1 ? vars.last.to_i : 1},
}

input = STDIN.gets_to_end.strip.split "\n"
registers = {"a" => 0, "b" => 0}
idx = 0
while idx < input.size
	line = input[idx].split /[ ,]/, remove_empty: true
	idx += instructions[line.first].call(registers, line[1..])
end
puts registers["b"]
