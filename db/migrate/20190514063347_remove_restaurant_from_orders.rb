class RemoveRestaurantFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :restaurant_id, :integer
  end
end
