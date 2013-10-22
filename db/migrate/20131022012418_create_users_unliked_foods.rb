class CreateUsersUnlikedFoods < ActiveRecord::Migration
  def change
    create_table :users_unliked_foods do |t|
      t.belongs_to :user, null: false
      t.belongs_to :unliked_food, null: false
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE users_unliked_foods
          ADD CONSTRAINT fk_users
          FOREIGN KEY (user_id)
          REFERENCES users(id),
          ADD CONSTRAINT fk_unliked_foods
          FOREIGN KEY (unliked_food_id)
          REFERENCES unliked_foods(id)
        SQL
      end
    end
  end
end
