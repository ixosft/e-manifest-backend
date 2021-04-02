class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :number
      t.string :manager_name
      t.timestamps
    end

    add_index :companies, %I[name]
  end
end
