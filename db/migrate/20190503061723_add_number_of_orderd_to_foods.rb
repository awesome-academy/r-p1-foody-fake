class AddNumberOfOrderdToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :number_of_ordered, :integer, default: 0
  end
end
