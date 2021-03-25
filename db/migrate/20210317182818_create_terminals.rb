class CreateTerminals < ActiveRecord::Migration[6.1]
  def change
    create_table :terminals do |t|
      t.string :name
      t.string :address
      t.string :state
      t.string :local_goverment
      t.integer :manager_id

      t.timestamps
    end
    add_index :terminals, %I[state]
    add_index :terminals, %I[manager_id]
    add_index :terminals, %I[local_goverment]
    add_index :terminals, %I[state local_goverment]
  end
end
