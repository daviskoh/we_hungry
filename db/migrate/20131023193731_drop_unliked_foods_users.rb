class DropUnlikedFoodsUsers < ActiveRecord::Migration
  def change
    drop_table :unliked_foods_users
  end
end
