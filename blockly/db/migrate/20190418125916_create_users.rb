class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login_id, null: false
      t.string :token

      t.timestamps
    end

    add_index :users, :login_id, unique: true
    add_index :users, :token, unique: true
  end
end
