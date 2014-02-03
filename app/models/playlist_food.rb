class PlaylistFood < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ingredients

  def include_preferences?(ingredients_array)
    ingredients_array.all? { |ing| self.ingredients.include? ing }
  end

  def self.recommend_food_for(user)
    Rails.cache.fetch(:playlist_foods_all, expires_in: 14.days) do
      PlaylistFood.all
    end.select { |food| food.include_preferences? user.top_ingredients }.sample
  end
end