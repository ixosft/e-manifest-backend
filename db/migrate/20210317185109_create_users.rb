class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username, null: false
      t.string :email
      t.string :password_digest
      t.integer :role, default: 1
      t.string :number

      t.timestamps
    end

    add_reference :users, :terminal, index: true
  end
end
