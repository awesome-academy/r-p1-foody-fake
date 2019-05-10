class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
