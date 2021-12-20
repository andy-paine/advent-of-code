require "digest/md5"
prefix = STDIN.gets_to_end.strip

num = (1..).find do |x|
  Digest::MD5.hexdigest("#{prefix}#{x}").starts_with? "000000"
end
puts num
