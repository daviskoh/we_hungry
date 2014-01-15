# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def food_in_db?(food)
  # PlaylistFood.all.any? { |playlist_food| playlist_food.name.downcase == food.name.downcase }
  !PlaylistFood.where('LOWER(name) = LOWER(?)', food.name).empty?
end

def ingredient_in_db?(ingredient)
  # Ingredient.all.any? { |ing| ing.name.downcase == ingredient.downcase }
  !Ingredient.where('LOWER(name) = LOWER(?)', ingredient).empty?
end

response = Yummly.search("main", maxResult: 101, start: 2000)

response.each do |recipe|
  # food = unless food_in_db?(recipe)
  #   PlaylistFood.create(name: recipe.name, image_url: recipe.thumbnail)
  # else
  #   PlaylistFood.find_by(name: recipe.name)
  # end

  # recipe.ingredients.each do |ing|
  #   unless ingredient_in_db?(ing)
  #     Ingredient.create(name: ing.downcase)
  #   end

  #   food.ingredients << Ingredient.where('LOWER(name) = LOWER(?)', ing)
  # end

  unless food_in_db?(recipe)
    PlaylistFood.create(name: recipe.name, image_url: recipe.thumbnail)
    recipe.ingredients.each { |ing| Ingredient.create(name: ing.downcase) }
  end
end
