class IngredientsUsers < ActiveRecord::Base
  belongs_to :user
  belongs_to :ingredients
end