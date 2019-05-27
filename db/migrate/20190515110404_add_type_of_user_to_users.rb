class AddTypeOfUserToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type_of_user, :string, default: "normal"
  end
end
