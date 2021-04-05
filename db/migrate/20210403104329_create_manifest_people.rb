class CreateManifestPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :manifest_people do |t|
      t.string :destination_state
      t.string :destination_local_goverment

      t.timestamps
    end

    add_index :manifest_people, %I[destination_state]
    add_index :manifest_people, %I[destination_local_goverment]
    add_reference :manifest_people, :person, index: true
    add_reference :manifest_people, :manifest, index: true
    add_index :manifest_people, %I[person_id manifest_id]
    add_index :manifest_people, %I[destination_state destination_local_goverment], name: :index_manifest_people_on_destination_and_lgt
    add_index :manifest_people, %I[person_id destination_state], name: :index_manifest_people_on_person_and_destination
  end
end
