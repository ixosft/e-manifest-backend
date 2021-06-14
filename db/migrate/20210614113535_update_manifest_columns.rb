class UpdateManifestColumns < ActiveRecord::Migration[6.1]
  def change
    remove_index :manifests, %I[source_terminal]
    remove_index :manifests, %I[destination_terminal]
    remove_index :manifests, %I[source_state source_terminal]
    remove_index :manifests, %I[source_terminal destination_terminal]
    remove_index :manifests, %I[destination_state destination_terminal]
    remove_index :manifests, name: :index_manifests_source_destination_state_terminal
    remove_index :manifests, name: :index_manifests_d_time_source_destination_state_terminal
    remove_column :manifests, :source_terminal
    remove_column :manifests, :destination_terminal

    add_column :manifests, :source_terminal_id, :integer
    add_column :manifests, :destination_terminal_id, :integer

    add_index :manifests, %I[source_terminal_id]
    add_index :manifests, %I[destination_terminal_id]
    add_index :manifests, %I[source_terminal_id destination_terminal_id], name: :index_manifest_source_dest_terminal_id
    add_index :manifests, %I[destination_terminal_id source_terminal_id], name: :index_manifest_dest_source_terminal_id
    add_index :manifests, %I[source_state destination_state source_terminal_id destination_terminal_id], name: :index_manifests_source_destination_state_terminal

    remove_index :manifest_people, %I[source_terminal]
    remove_index :manifest_people, %I[destination_terminal]
    remove_index :manifest_people, name: :index_manifest_people_src_dest_state_terminal
    remove_index :manifest_people, name: :index_manifest_people_source_destination_terminal

    remove_column :manifest_people, :source_terminal
    remove_column :manifest_people, :destination_terminal

    add_column :manifest_people, :source_terminal_id, :integer
    add_column :manifest_people, :destination_terminal_id, :integer

    add_index :manifest_people, %I[source_terminal_id]
    add_index :manifest_people, %I[destination_terminal_id]
    add_index :manifest_people, %I[source_terminal_id destination_terminal_id], name: :index_manifest_people_source_destination_terminal
    add_index :manifest_people, %I[destination_terminal_id source_terminal_id], name: :index_manifest_people_dest_source_terminal
    add_index :manifest_people, %I[source_state destination_state source_terminal_id destination_terminal_id], name: :index_manifest_people_src_dest_state_terminal
  end
end
