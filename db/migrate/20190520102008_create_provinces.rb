class CreateProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :provinces do |t|
      t.string :provinceid
      t.string :name

      t.timestamps
    end
  end
end
