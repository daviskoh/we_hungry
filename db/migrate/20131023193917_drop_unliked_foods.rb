class DropUnlikedFoods < ActiveRecord::Migration
  def change
    drop_table :unliked_foods
  end
end
