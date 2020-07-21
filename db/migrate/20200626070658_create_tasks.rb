class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true, index: false, null: false

      t.timestamps
    end
    add_index :tasks, [:group_id, :created_at]
  end
end
