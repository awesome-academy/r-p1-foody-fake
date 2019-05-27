class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :restaurants, :user_id, :manager_id
  end
end
