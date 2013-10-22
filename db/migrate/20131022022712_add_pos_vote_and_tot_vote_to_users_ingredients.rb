class AddPosVoteAndTotVoteToUsersIngredients < ActiveRecord::Migration
  def change
    add_column :users_ingredients, :pos_votes, :integer
    add_column :users_ingredients, :tot_votes, :integer, default: 0
  end
end
