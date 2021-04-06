class AddDeleteAtToAllTables < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :deleted_at, :datetime
    add_column :companies, :deleted_at, :datetime
    add_column :terminals, :deleted_at, :datetime
    add_column :motors, :deleted_at, :datetime
    add_column :people, :deleted_at, :datetime
    add_column :manifests, :deleted_at, :datetime
    add_index :users, %I[deleted_at]
    add_index :companies, %I[deleted_at]
    add_index :terminals, %I[deleted_at]
    add_index :motors, %I[deleted_at]
    add_index :people, %I[deleted_at]
    add_index :manifests, %I[deleted_at]
  end
end
