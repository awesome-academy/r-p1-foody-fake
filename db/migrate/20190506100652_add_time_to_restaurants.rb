class AddTimeToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :open_time, :integer
    add_column :restaurants, :close_time, :integer
  end
end
