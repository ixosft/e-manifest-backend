class AddPriceToManifestPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :manifest_people, :amount, :money
    add_column :manifest_people, :ticket_uid, :string

    add_index :manifest_people, %I[ticket_uid]
  end
end
