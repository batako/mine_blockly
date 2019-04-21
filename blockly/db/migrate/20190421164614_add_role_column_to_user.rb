class AddRoleColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 0, null: false
  end
end
