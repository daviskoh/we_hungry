class Ren < ActiveRecord::Migration
  def change
    rename_table :users_playlist_foods, :playlist_foods_users
  end
end
