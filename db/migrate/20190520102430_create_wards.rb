class CreateWards < ActiveRecord::Migration[5.2]
  def change
    create_table :wards do |t|
      t.string :districtid
      t.string :wardid
      t.string :name

      t.timestamps
    end
  end
end
