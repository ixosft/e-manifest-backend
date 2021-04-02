class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username, null: false
      t.string :email
      t.string :password_digest
      t.integer :role, default: 1
      t.string :number
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :users, :active
    add_index :users, :name
    add_index :users, %I[email]
    add_index :users, %I[name username]
    add_index :users, %I[username], unique: true
    add_reference :users, :terminal, index: true
  end
end
