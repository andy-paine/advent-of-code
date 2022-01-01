require "digest/md5"

prefix = STDIN.gets_to_end.strip
password = 8.times.reduce({"########".chars, 0}) do |(pwd,idx)|
  (idx+1..).each do |i|
    dig = Digest::MD5.hexdigest("#{prefix}#{i}")
    next unless dig[5].to_i?
    break {pwd.fill(dig[6], dig[5].to_i..dig[5].to_i),i} if dig.starts_with?("00000") && pwd.fetch(dig[5].to_i, '-') == '#'
  end
  {pwd,idx}
end
puts password.first.join
