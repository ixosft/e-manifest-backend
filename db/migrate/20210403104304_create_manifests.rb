class CreateManifests < ActiveRecord::Migration[6.1]
  def change
    create_table :manifests do |t|
      t.string :source_state
      t.string :destination_state

      t.timestamps
    end

    add_index :manifests, %I[source_state]
    add_index :manifests, %I[destination_state]
    add_index :manifests, %I[source_state destination_state]
    add_reference :manifests, :motor, index: true
    add_reference :manifests, :company, index: true
    add_reference :manifests, :terminal, index: true
    add_index :manifests, %I[company_id motor_id]
    add_index :manifests, %I[company_id terminal_id]
    add_index :manifests, %I[company_id terminal_id motor_id]
  end
end
