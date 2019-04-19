class AddCreatedByAndShareColumnToWorkspace < ActiveRecord::Migration[5.1]
  def up
    add_column :workspaces, :created_by, :integer
    change_column :workspaces, :created_by, :integer, null: false
    add_index :workspaces, :created_by

    add_column :workspaces, :share, :boolean, default: false, null: false
  end

  def down
    remove_column :workspaces, :created_by
    remove_column :workspaces, :share
  end
end
