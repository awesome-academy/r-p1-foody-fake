class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.integer :min_price
      t.integer :max_price
      t.string :image
      t.integer :open_time
      t.integer :close_time

      t.timestamps
    end
  end
end
