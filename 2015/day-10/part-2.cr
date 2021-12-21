require "yaml"

elements = File.open("elements.yml"){ |f| YAML.parse(f)}.as_h
start = STDIN.gets_to_end.strip

elem = elements.find{|_,v| v["value"] == start}.not_nil!.first
result = 50.times.reduce([elem]) do |res|
  res.map{|e| elements[e]["decays"].as_a}.flatten
end
puts result.reduce(0_i64){|total,e| total + elements[e]["value"].as_s.size}
