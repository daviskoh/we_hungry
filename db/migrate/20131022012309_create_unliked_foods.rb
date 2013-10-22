class CreateUnlikedFoods < ActiveRecord::Migration
  def change
    create_table :unliked_foods do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
