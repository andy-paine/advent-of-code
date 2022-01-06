alias Move = Proc(Array(Array(Bool)), Int32, Int32, Nil)

moves = {
  "rect"   => Move.new { |screen, width, height| (0...height).each { |h| (0...width).each { |w| screen[h][w] = true } } },
  "row"    => Move.new { |screen, r, by| screen[r] = screen[r].rotate(-1*by) },
  "column" => Move.new { |screen, col, by| new_col = screen.transpose[col].rotate(-1*by); 6.times { |i| screen[i][col] = new_col[i] } },
}

screen = Array(Array(Bool)).new(6) { Array(Bool).new(50, false) }
STDIN
  .gets_to_end
  .strip
  .split("\n")
  .compact_map { |l| /(?:rotate)?((column)|(row)|(rect))\D+(\d+)\D+(\d+)/.match(l) }
  .map { |m| m.captures.compact.last(3) }
  .each { |(m, i, j)| moves[m].call(screen, i.to_i, j.to_i) }

screen.each { |l| puts l.map { |c| c ? '⬜' : '⬛' }.join }
