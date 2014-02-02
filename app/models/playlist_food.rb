class PlaylistFood < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ingredients

  def include_preferences?(ingredients_array)
    ingredients_array.all? { |ing| self.ingredients.include? ing }
  end
end