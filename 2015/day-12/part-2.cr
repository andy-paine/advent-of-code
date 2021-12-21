require "json"

def strip_red(node : JSON::Any) : JSON::Any
  case node
  when .as_i?
    node
  when .as_s?
    node
  when .as_a?
    JSON::Any.new node.as_a.map { |n| strip_red(n) }
  when .as_h?
    return JSON::Any.new nil if node.as_h.any? { |k, v| v.as_s? && v.as_s == "red" }
    JSON::Any.new node.as_h.map { |k, n| {k, strip_red(n)} }.to_h
  else
    node
  end
end

input = STDIN.gets_to_end.strip
stripped_input = strip_red(JSON.parse(input)).to_s
puts stripped_input.scan(/-?\d+/).reduce(0) { |sum, match| sum + match[0].to_i }
