require "digest/md5"

prefix = STDIN.gets_to_end.strip
pwd_idxs = 8.times.reduce([0] of Int32) do |pi|
  pi.push (pi.last+1..).each.find{|i| Digest::MD5.hexdigest("#{prefix}#{i}").starts_with? "00000"}.not_nil!
end
puts pwd_idxs[1..].map{|i| Digest::MD5.hexdigest("#{prefix}#{i}")[5]}.join
