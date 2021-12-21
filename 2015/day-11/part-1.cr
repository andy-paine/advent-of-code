ALL_LETTERS = "abcdefghijklmnopqrstuvwxyz".chars
LETTERS   = "abcdefghjkmnpqrstuvwxyz".chars
STRAIGHTS = ALL_LETTERS.each.cons(3).map(&.join).to_a
DOUBLES   = LETTERS.map { |l| [l, l].join }

def increment(password : String) : String
  password = password.chars
  index = password.size - 1
  until password[index] != ALL_LETTERS.last
    password[index] = ALL_LETTERS.first
    index -= 1
  end
  current = ALL_LETTERS.index(password[index]).not_nil!
  password[index] = ALL_LETTERS[current + 1]
  password.join
end

def valid?(password : String) : Bool
  password.chars.all? { |c| LETTERS.includes? c } &&
    STRAIGHTS.any? { |s| password.includes? s } &&
    DOUBLES.count { |d| password.includes? d } >= 2
end

password = STDIN.gets_to_end.strip
until valid?(password)
  password = increment(password)
end
puts password
