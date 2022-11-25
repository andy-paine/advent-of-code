require "digest"

SALT = STDIN.gets_to_end.strip.split("\n").first
HASHES = {} of Int64 => String

# Don't compute hashes twice
def get_hash(num): String
  HASHES[num] if HASHES.has_key? num
  HASHES[num] = 2017.times.reduce(SALT + num.to_s) {|hash,_| Digest::MD5.hexdigest(hash) }
end

puts (1..).reduce([] of Int32) do |match, i|
  puts "Checking key #{i}"
  break match if match.size >= 64
  char = get_hash(i).chars.each.cons(3).select{|cs| cs.uniq.size == 1}.first?.try(&.first)
  next match unless char
  next match unless (i+1..i+1000).any?{|j| get_hash(j).chars.each.cons(5).any?{|cs| cs.all?(&.== char)}}
  match + [i]
end.not_nil!.last
