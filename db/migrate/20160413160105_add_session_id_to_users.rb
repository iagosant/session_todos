class AddSessionIdToUsers < ActiveRecord::Migration
  def up
    add_column :users, :session_id, :integer
  end
  def down
    remove_column :users, :session_id, :integer  
  end
end
