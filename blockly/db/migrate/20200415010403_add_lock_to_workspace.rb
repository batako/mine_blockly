class AddLockToWorkspace < ActiveRecord::Migration[6.0]
  def change
    add_column :workspaces, :lock, :boolean
  end
end
