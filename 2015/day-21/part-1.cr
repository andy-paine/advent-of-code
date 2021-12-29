record Item, cost : Int32, damage : Int32, armor : Int32
nothing = Item.new 0, 0, 0

weapons = {
  "Dagger"     => Item.new(8, 4, 0),
  "Shortsword" => Item.new(10, 5, 0),
  "Warhammer"  => Item.new(25, 6, 0),
  "Longsword"  => Item.new(40, 7, 0),
  "Greataxe"   => Item.new(74, 8, 0),
  "Nothing"    => nothing,
}

armors = {
  "Leather"    => Item.new(13, 0, 1),
  "Chainmail"  => Item.new(31, 0, 2),
  "Splitmail"  => Item.new(53, 0, 3),
  "Bandedmail" => Item.new(75, 0, 4),
  "Platemail"  => Item.new(102, 0, 5),
  "Nothing"    => nothing,
}

rings = {
  "Damage +1"  => Item.new(25, 1, 0),
  "Damage +2"  => Item.new(50, 2, 0),
  "Damage +3"  => Item.new(100, 3, 0),
  "Defense +1" => Item.new(20, 0, 1),
  "Defense +2" => Item.new(40, 0, 2),
  "Defense +3" => Item.new(80, 0, 3),
  "Nothing #1" => nothing,
  "Nothing #2" => nothing,
}

class Player
  property hp
  getter damage
  getter armor

  def initialize(@hp : Int32, @damage : Int32, @armor : Int32)
  end
end

def play(player : Player, boss : Player) : Bool
  players = [player, boss]
  until players.any?{|p| p.hp <= 0}
    dmg = Math.max(players.first.damage - players.last.armor, 1)
    players.last.hp -= dmg
    players.rotate!
  end
  return player.hp.positive?
end

boss_details = STDIN.gets_to_end.strip.split("\n").map(&.split(": ").last.to_i)
boss = Player.new boss_details[0], boss_details[1], boss_details[2]

lowest_cost = Int32::MAX
weapons.values.each do |weapon|
	armors.values.each do |armor|
  	rings.values.combinations(2).each do |(r1,r2)|
  		cost = weapon.cost + armor.cost + r1.cost + r2.cost
    	next if cost >= lowest_cost
    	player = Player.new 100, weapon.damage + r1.damage + r2.damage, armor.armor + r1.armor + r2.armor
    	lowest_cost = cost if play(player, boss.dup)
  	end
	end
end
puts lowest_cost
