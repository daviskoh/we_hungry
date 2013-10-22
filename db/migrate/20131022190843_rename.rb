class Rename < ActiveRecord::Migration
  def change
    rename_table :users_unliked_foods, :unliked_foods_users
  end
end
