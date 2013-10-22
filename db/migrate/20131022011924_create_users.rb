class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false

      t.boolean :vege, default: false
      t.boolean :vegan, default: false
      t.boolean :lactose, default: false
      t.boolean :nut, default: false

      t.timestamps
    end
  end
end
