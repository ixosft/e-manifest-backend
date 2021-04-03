class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :full_name
      t.string :number
      t.integer :person_type, default: 1
      t.string :next_of_kin_name
      t.string :next_of_kin_number
      t.string :next_of_kin_address
      t.string :next_of_kin_relationship

      t.timestamps
    end

    add_index :people, %I[person_type]
    add_index :people, %I[number]
    add_index :people, %I[full_name]
    add_index :people, %I[person_type number]
    add_index :people, %I[person_type full_name]
    add_index :people, %I[person_type number full_name]
  end
end
