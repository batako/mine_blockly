class CreateWorkspaces < ActiveRecord::Migration[5.1]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.string :xml

      t.timestamps
    end
  end
end
