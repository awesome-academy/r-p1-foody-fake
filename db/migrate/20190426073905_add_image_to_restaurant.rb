class AddImageToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :image, :string
  end
end
