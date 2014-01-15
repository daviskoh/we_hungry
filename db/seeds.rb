# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rails.cache.write('all_food', PlaylistFood.all)
Rails.cache.write('all_ing', Ingredient.all)

def food_in_db?(food)
  Rails.cache.fetch('all_food').any? { |playlist_food| playlist_food.name.downcase == food.name.downcase }
end

def ingredient_in_db?(ingredient)
  Rails.cache.fetch('all_ing').any? { |ing| ing.name.downcase == ingredient.downcase }
end

response = Yummly.search("main", maxResult: 5, start: 1)

response.each do |recipe|
  food = unless food_in_db?(recipe)
    PlaylistFood.create(name: recipe.name, image_url: recipe.thumbnail)
  else
    PlaylistFood.find_by(name: recipe.name)
  end

  recipe.ingredients.each do |ing|
    unless ingredient_in_db?(ing)
      Ingredient.create(name: ing.downcase)
    end

    food.ingredients << Ingredient.find_by(name: ing.downcase)
  end
end

Rails.cache.delete('all_food')
Rails.cache.delete('all_ing')