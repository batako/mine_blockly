class AddPinToWorkspace < ActiveRecord::Migration[5.1]
  def change
    add_column :workspaces, :pin, :boolean, default: false, null: false
    add_index :workspaces, :pin
  end
end
