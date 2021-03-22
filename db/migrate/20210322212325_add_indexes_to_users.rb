class AddIndexesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, %I[email]
    add_index :users, %I[username], unique: true
  end
end
