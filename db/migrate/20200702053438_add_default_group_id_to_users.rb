class AddDefaultGroupIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :default_group_id, :integer
  end
end
