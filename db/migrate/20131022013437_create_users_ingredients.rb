class CreateUsersIngredients < ActiveRecord::Migration
  def change
    create_table :users_ingredients do |t|
      t.belongs_to :user, null: false
      t.belongs_to :ingredient, null: false
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE users_ingredients
          ADD CONSTRAINT fk_users
          FOREIGN KEY (user_id)
          REFERENCES users(id),
          ADD CONSTRAINT fk_ingredients
          FOREIGN KEY (ingredient_id)
          REFERENCES ingredients(id)
        SQL
      end
    end
  end
end
