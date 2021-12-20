values = STDIN.gets_to_end.strip.split("\n")
  .map(&.split " -> ")
  .map(&.reverse)
  .to_h

ops = {
  "AND"    => ->(a : UInt16, b : UInt16) { a & b },
  "OR"     => ->(a : UInt16, b : UInt16) { a | b },
  "LSHIFT" => ->(a : UInt16, b : UInt16) { a << b },
  "RSHIFT" => ->(a : UInt16, b : UInt16) { a >> b },
}

def value(values, ops, c) : UInt16
  return c.to_u16 if c.to_u16?
  return values[c].to_u16 if values[c].to_u16?
  vals = values[c].split
  return value(values, ops, vals.last) if vals.size == 1
  return UInt16::MAX - value(values, ops, vals.last) if vals.size == 2
  val = ops[vals[1]].call(value(values, ops, vals.first), value(values, ops, vals.last))
  values[c] = val.to_s
  val
end

puts value(values, ops, "a")
