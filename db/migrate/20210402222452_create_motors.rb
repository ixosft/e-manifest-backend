class CreateMotors < ActiveRecord::Migration[6.1]
  def change
    create_table :motors do |t|
      t.string :model
      t.integer :brand
      t.string :color
      t.integer :year
      t.string :chasis_number
      t.string :number_plate, unique: true

      t.timestamps
    end

    add_reference :motors, :people, index: true
    add_index :motors, %I[model]
    add_index :motors, %I[brand]
    add_index :motors, %I[chasis_number]
    add_index :motors, %I[brand model]
  end
end
