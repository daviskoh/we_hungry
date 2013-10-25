class ChangePosVotes < ActiveRecord::Migration
  def change
    change_column :ingredients_users, :pos_votes, :integer, default: 0
  end
end
