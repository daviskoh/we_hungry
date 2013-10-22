class CreateUsersPlaylistFoods < ActiveRecord::Migration
  def change
    create_table :users_playlist_foods do |t|
      t.belongs_to :user, null: false
      t.belongs_to :playlist_food, null: false
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE users_playlist_foods
          ADD CONSTRAINT fk_users
          FOREIGN KEY (user_id)
          REFERENCES users(id),
          ADD CONSTRAINT fk_playlist_foods
          FOREIGN KEY (playlist_food_id)
          REFERENCES playlist_foods(id)
        SQL
      end
    end
  end
end
