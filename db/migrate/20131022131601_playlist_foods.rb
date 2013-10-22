class PlaylistFoods < ActiveRecord::Migration
  def change
    create_table :playlist_foods do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
