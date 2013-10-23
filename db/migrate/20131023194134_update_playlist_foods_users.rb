class UpdatePlaylistFoodsUsers < ActiveRecord::Migration
  def change
    add_column :playlist_foods_users, :liked, :boolean
  end
end
