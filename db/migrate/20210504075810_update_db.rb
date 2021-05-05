class UpdateDb < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :nim, :string
    add_column :people, :sex, :integer

    add_index :people, %I[sex]
    add_index :people, %I[full_name number]
    add_index :people, %I[sex full_name number]

    remove_index :motors, %I[chasis_number]
    remove_index :motors, %I[brand model]
    remove_index :motors, %I[model]
    remove_column :motors, :year
    remove_column :motors, :model
    remove_column :motors, :chasis_number
    add_column :motors, :seat_number, :integer
    add_column :motors, :motor_type, :string

    add_index :motors, %I[motor_type]
    add_index :motors, %I[number_plate]

    add_column :manifests, :source_terminal, :string
    add_column :manifests, :destination_terminal, :string
    add_column :manifests, :departure_time, :time

    add_index :manifests, %I[departure_time]
    add_index :manifests, %I[source_terminal]
    add_index :manifests, %I[destination_terminal]
    add_index :manifests, %I[source_state source_terminal]
    add_index :manifests, %I[source_terminal destination_terminal]
    add_index :manifests, %I[destination_state destination_terminal]
    add_index :manifests, %I[source_terminal destination_terminal destination_state destination_terminal], name: :index_manifests_source_destination_state_terminal
    add_index :manifests, %I[departure_time source_terminal destination_terminal destination_state destination_terminal], name: :index_manifests_d_time_source_destination_state_terminal

    remove_index :terminals, %I[local_goverment]
    remove_index :terminals, %I[state local_goverment]
    rename_column :terminals, :local_goverment, :terminal

    add_index :terminals, %I[terminal]
    add_index :terminals, %I[state terminal]

    remove_index :manifest_people, name: :index_manifest_people_on_destination_and_lgt
    remove_index :manifest_people, %I[destination_local_goverment]
    add_column :manifest_people, :source_state, :string
    add_column :manifest_people, :source_terminal, :string
    rename_column :manifest_people, :destination_local_goverment, :destination_terminal

    add_index :manifest_people, %I[source_state]
    add_index :manifest_people, %I[source_terminal]
    add_index :manifest_people, %I[destination_terminal]
    add_index :manifest_people, %I[source_state destination_state], name: :index_manifest_people_source_destination
    add_index :manifest_people, %I[source_terminal destination_terminal], name: :index_manifest_people_source_destination_terminal
    add_index :manifest_people, %I[source_state source_terminal destination_state destination_terminal], name: :index_manifest_people_src_dest_state_terminal
  end
end
