class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_and_belongs_to_many :ingredients
  # has_many :ingredients, :through => :ingredient_user
  has_and_belongs_to_many :playlist_foods

  has_secure_password

  def top_ingredients(amount = 2) # default to LIMIT 2
    ci_lower_bound_query = "((pos_votes + 1.9208) / tot_votes - 1.96 * SQRT((pos_votes * (tot_votes - pos_votes)) / tot_votes + 0.9604) / tot_votes) / (1 + 3.8416 / tot_votes) DESC LIMIT #{amount}"

    relationships = IngredientsUsers.where('user_id = ? AND tot_votes > 0', self.id).order(ci_lower_bound_query)

    if relationships.empty?
      Ingredient.order('random() LIMIT 2')
    else
      # must change below if want amount to be dynamic
      Ingredient.where("id = ? OR id = ?", relationships[0].ingredient_id, relationships[1].ingredient_id)
    end
  end
end