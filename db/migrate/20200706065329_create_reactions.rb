class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
    add_index :reactions, :user_id
    add_index :reactions, [:task_id, :user_id], unique: true
  end
end
