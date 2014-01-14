# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def food_in_db?(food)
  PlaylistFood.all.any? { |playlist_food| playlist_food.name.downcase == food.name.downcase }
end

def ingredient_in_db?(ingredient)
  Ingredient.all.any? { |ing| ing.name.downcase == ingredient.downcase }
end

response = Yummly.search(" ", maxResult: 800, start: 2000)

response.each do |recipe|
  unless food_in_db?(recipe)
    @food = PlaylistFood.create(name: recipe.name, image_url: recipe.thumbnail)
  end

  recipe.ingredients.each do |ing|
    unless ingredient_in_db?(ing)
      Ingredient.create(name: ing)
    end

    PlaylistFood.last.ingredients << Ingredient.find_by(name: ing)
  end
end



