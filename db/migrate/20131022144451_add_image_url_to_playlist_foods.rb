class AddImageUrlToPlaylistFoods < ActiveRecord::Migration
  def change
    add_column :playlist_foods, :image_url, :string
  end
end
