primes = (2..20).reduce(Set(Int32).new) do |primes, n|
  primes.none? { |p| n % p == 0 } ? primes.add(n) : primes
end

house = (1..).find do |h|
  factors = [1]
  until h == 1
    factor = primes.find { |n| h % n == 0 }
    break unless factor
    factors.push(factor)
    h = (h/factor).to_i
  end unless primes.includes? h
  prs = [] of Int32
  (1...factors.size).each do |i|
    factors.combinations(i)
    prs += factors.combinations(i).map(&.product)
  end
  prs.uniq.sum * 10 >= 36000000
end
puts house
