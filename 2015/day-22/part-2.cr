class Player
  property hp : Int32 = 50
  property mana : Int32 = 500
  property extra_mana : Int32 = 0
  property armor : Int32 = 0

  def total_mana
    mana + extra_mana
  end

  def to_s
    "HP: #{hp}, mana: #{mana}"
  end
end

class Boss
  property hp
  getter damage

  def initialize(@hp : Int32, @damage : Int32)
  end
end

alias Effect = Proc(Player, Boss, Nil)
alias Game = Tuple(Player, Boss, Hash(Effect, Int32), Array(Spell))
record Spell, name : String, cost : Int32, effect_duration : Int32, effect : Effect

SPELLS = [
  Spell.new("Magic Missile", 53, 0, Effect.new { |_, b| b.hp -= 4 }),
  Spell.new("Drain", 73, 0, Effect.new { |p, b| p.hp += 2; b.hp -= 2 }),
  Spell.new("Shield", 113, 6, Effect.new { |p, _| p.armor = 7 }),
  Spell.new("Poison", 173, 6, Effect.new { |_, b| b.hp -= 3 }),
  Spell.new("Recharge", 229, 5, Effect.new { |p, _| p.extra_mana += 101 }),
]

def apply_effects(p : Player, b : Boss, effects : Hash(Effect, Int32))
  p.armor = 0
  effects.keys.each do |effect|
    effect.call(p, b)
    effects[effect] -= 1
  end
  effects.reject!{|_,v| v.zero?}
end

def cast(p : Player, b : Boss, spell : Spell, effects : Hash(Effect, Int32))
  apply_effects(p, b, effects)
  return unless b.hp.positive?
  p.mana -= spell.cost
  if spell.effect_duration == 0
   	spell.effect.call(p, b)
  else
   	effects[spell.effect] = spell.effect_duration
  end
end

def attack(p : Player, b : Boss, effects : Hash(Effect, Int32))
  apply_effects(p, b, effects)
  return unless b.hp.positive?
	p.hp -= Math.max(b.damage - p.armor, 1)
end

def cost(g : Game)
	g.last.map(&.cost).sum
end

player = Player.new
boss = Boss.new 55, 8
games = SPELLS.map{|s| {player.dup, boss.dup, {} of Effect => Int32, [s]}}
min = Int32::MAX
until games.empty?
  games = games.reject{|g| cost(g) > min}.map do |p,b,effs,spells|
    p.hp -= 1
		next {p, b, effs, spells} unless p.hp.positive?
		cast(p, b, spells.last, effs)
		next {p, b, effs, spells} unless b.hp.positive?
		attack(p, b, effs)
		{p, b, effs, spells}
	end

	winning_costs = games.select{|p,_,_,_| p.hp.positive?}.select{|_,b,_,_| !b.hp.positive?}.map{|g| cost(g)}
	#winning_games = games.select{|_,b,_,_| !b.hp.positive?}.map{|g| {g.first, g.last, cost(g)}}
  #puts "Game won with cost #{winning_games.min_of(&.last)} (#{winning_games.min_by(&.last)[1].map(&.name)}) with player #{winning_games.min_by(&.last).first.to_s}" unless winning_games.empty?
  min = winning_costs.min if !winning_costs.empty? && winning_costs.min < min
  games = games.select{|p,b,_,_| p.hp.positive? && b.hp.positive?}.map do |p,b,effs,spells|
  	SPELLS.select{|s| s.cost <= p.total_mana}.reject{|s| effs.has_key? s}.map do |s|
  	{p.dup, b.dup, effs.dup, spells.dup.push(s)}
		end
	end.flatten
end
puts min
