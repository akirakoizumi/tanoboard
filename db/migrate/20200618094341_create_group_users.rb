class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :group, foreign_key: true, index: false, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :group_users, [:group_id, :user_id], unique: true
  end
end
