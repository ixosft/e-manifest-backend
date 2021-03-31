# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_31_095214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "terminals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "state"
    t.string "local_goverment"
    t.integer "manager_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["local_goverment"], name: "index_terminals_on_local_goverment"
    t.index ["manager_id"], name: "index_terminals_on_manager_id"
    t.index ["state", "local_goverment"], name: "index_terminals_on_state_and_local_goverment"
    t.index ["state"], name: "index_terminals_on_state"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 1
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "terminal_id"
    t.boolean "active", default: true
    t.index ["active"], name: "index_users_on_active"
    t.index ["email"], name: "index_users_on_email"
    t.index ["terminal_id"], name: "index_users_on_terminal_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
