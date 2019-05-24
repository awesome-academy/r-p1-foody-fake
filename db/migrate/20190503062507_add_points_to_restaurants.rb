class AddPointsToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :quality_point, :float, default: 0.0
    add_column :restaurants, :price_point, :float, default: 0.0
    add_column :restaurants, :service_point, :float, default: 0.0
    add_column :restaurants, :space_point, :float, default: 0.0
    add_column :restaurants, :location_point, :float, default: 0.0
    add_column :restaurants, :number_of_shared, :integer, default: 0
    add_column :restaurants, :number_of_rated, :integer, default: 0
  end
end
