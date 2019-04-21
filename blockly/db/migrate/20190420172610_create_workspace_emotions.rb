class CreateWorkspaceEmotions < ActiveRecord::Migration[5.1]
  def change
    create_table :workspace_emotions do |t|
      t.references :workspace, foreign_key: true
      t.integer :emotion
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
