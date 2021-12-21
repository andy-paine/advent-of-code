record Ingredient, name : String, capacity : Int32, durability : Int32, flavor : Int32, texture : Int32, calories : Int32

ingredients = STDIN.gets_to_end.strip.split("\n")
  .compact_map { |l| /(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (\d+)/.match l }
  .map { |m| Ingredient.new m[1], m[2].to_i, m[3].to_i, m[4].to_i, m[5].to_i, m[6].to_i }

alias Score = Tuple(Int32, Int32, Int32, Int32)

def add(s1, s2)
  Score.from (0..3).map { |i| s1[i] + s2[i] }
end

def scores(ingredients : Array(Ingredient), amount) : Array(Score)
  ingredient = ingredients.first
  return [{ingredient.capacity, ingredient.durability, ingredient.flavor, ingredient.texture}.map(&.* amount)] if ingredients.one?
  (1..amount - ingredients.size).map do |spoons|
    other_ingredients = scores(ingredients[1..], amount - spoons)
    other_ingredients.map do |oi|
      add(
        {ingredient.capacity, ingredient.durability, ingredient.flavor, ingredient.texture}.map(&.* spoons),
        oi
      )
    end
  end.flatten
end

puts scores(ingredients, 100).map { |s| s.map { |p| Math.max(p, 0) } }.map { |p| p.product }.max
