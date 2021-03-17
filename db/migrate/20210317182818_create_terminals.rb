class CreateTerminals < ActiveRecord::Migration[6.1]
  def change
    create_table :terminals do |t|
      t.string :name
      t.string :address
      t.integer :state
      t.integer :local_goverment
      t.string :manage_name

      t.timestamps
    end
  end
end
