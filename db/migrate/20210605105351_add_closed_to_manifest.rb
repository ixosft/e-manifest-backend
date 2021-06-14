class AddClosedToManifest < ActiveRecord::Migration[6.1]
  def change
    add_column :manifests, :closed, :boolean, default: false

    add_index :manifests, %I[closed]
  end
end
