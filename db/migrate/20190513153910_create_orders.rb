class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :restaurant, foreign_key: true
      t.references :user, foreign_key: true
      t.string :address
      t.string :name
      t.string :status
      t.string :phone
      t.string :order_date

      t.timestamps
    end
  end
end
