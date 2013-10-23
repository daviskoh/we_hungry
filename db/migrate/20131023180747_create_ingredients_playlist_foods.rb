class CreateIngredientsPlaylistFoods < ActiveRecord::Migration
  def change
    create_table :ingredients_playlist_foods do |t|
      t.belongs_to :playlist_food, null: false
      t.belongs_to :ingredient, null: false
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE ingredients_playlist_foods
          ADD CONSTRAINT fk_playlist_foods
          FOREIGN KEY (playlist_food_id)
          REFERENCES playlist_foods(id),
          ADD CONSTRAINT fk_ingredients
          FOREIGN KEY (ingredient_id)
          REFERENCES ingredients(id)
        SQL
      end
    end
  end
end
