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

ActiveRecord::Schema.define(version: 2021_06_14_113535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "number"
    t.string "manager_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_companies_on_deleted_at"
    t.index ["name"], name: "index_companies_on_name"
  end

  create_table "manifest_people", force: :cascade do |t|
    t.string "destination_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id"
    t.bigint "manifest_id"
    t.string "source_state"
    t.money "amount", scale: 2
    t.string "ticket_uid"
    t.integer "source_terminal_id"
    t.integer "destination_terminal_id"
    t.index ["destination_state"], name: "index_manifest_people_on_destination_state"
    t.index ["destination_terminal_id", "source_terminal_id"], name: "index_manifest_people_dest_source_terminal"
    t.index ["destination_terminal_id"], name: "index_manifest_people_on_destination_terminal_id"
    t.index ["manifest_id"], name: "index_manifest_people_on_manifest_id"
    t.index ["person_id", "destination_state"], name: "index_manifest_people_on_person_and_destination"
    t.index ["person_id", "manifest_id"], name: "index_manifest_people_on_person_id_and_manifest_id"
    t.index ["person_id"], name: "index_manifest_people_on_person_id"
    t.index ["source_state", "destination_state", "source_terminal_id", "destination_terminal_id"], name: "index_manifest_people_src_dest_state_terminal"
    t.index ["source_state", "destination_state"], name: "index_manifest_people_source_destination"
    t.index ["source_state"], name: "index_manifest_people_on_source_state"
    t.index ["source_terminal_id", "destination_terminal_id"], name: "index_manifest_people_source_destination_terminal"
    t.index ["source_terminal_id"], name: "index_manifest_people_on_source_terminal_id"
    t.index ["ticket_uid"], name: "index_manifest_people_on_ticket_uid"
  end

  create_table "manifests", force: :cascade do |t|
    t.string "source_state"
    t.string "destination_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "motor_id"
    t.bigint "company_id"
    t.bigint "terminal_id"
    t.datetime "deleted_at"
    t.time "departure_time"
    t.boolean "closed", default: false
    t.integer "source_terminal_id"
    t.integer "destination_terminal_id"
    t.index ["closed"], name: "index_manifests_on_closed"
    t.index ["company_id", "motor_id"], name: "index_manifests_on_company_id_and_motor_id"
    t.index ["company_id", "terminal_id", "motor_id"], name: "index_manifests_on_company_id_and_terminal_id_and_motor_id"
    t.index ["company_id", "terminal_id"], name: "index_manifests_on_company_id_and_terminal_id"
    t.index ["company_id"], name: "index_manifests_on_company_id"
    t.index ["deleted_at"], name: "index_manifests_on_deleted_at"
    t.index ["departure_time"], name: "index_manifests_on_departure_time"
    t.index ["destination_state"], name: "index_manifests_on_destination_state"
    t.index ["destination_terminal_id", "source_terminal_id"], name: "index_manifest_dest_source_terminal_id"
    t.index ["destination_terminal_id"], name: "index_manifests_on_destination_terminal_id"
    t.index ["motor_id"], name: "index_manifests_on_motor_id"
    t.index ["source_state", "destination_state", "source_terminal_id", "destination_terminal_id"], name: "index_manifests_source_destination_state_terminal"
    t.index ["source_state", "destination_state"], name: "index_manifests_on_source_state_and_destination_state"
    t.index ["source_state"], name: "index_manifests_on_source_state"
    t.index ["source_terminal_id", "destination_terminal_id"], name: "index_manifest_source_dest_terminal_id"
    t.index ["source_terminal_id"], name: "index_manifests_on_source_terminal_id"
    t.index ["terminal_id"], name: "index_manifests_on_terminal_id"
  end

  create_table "motors", force: :cascade do |t|
    t.integer "brand"
    t.string "color"
    t.string "number_plate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id"
    t.datetime "deleted_at"
    t.integer "seat_number"
    t.string "motor_type"
    t.index ["brand"], name: "index_motors_on_brand"
    t.index ["deleted_at"], name: "index_motors_on_deleted_at"
    t.index ["motor_type"], name: "index_motors_on_motor_type"
    t.index ["number_plate"], name: "index_motors_on_number_plate"
    t.index ["person_id", "brand"], name: "index_motors_on_person_id_and_brand"
    t.index ["person_id"], name: "index_motors_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "full_name"
    t.string "number"
    t.integer "person_type", default: 1
    t.string "next_of_kin_name"
    t.string "next_of_kin_number"
    t.string "next_of_kin_address"
    t.string "next_of_kin_relationship"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "nim"
    t.integer "sex"
    t.index ["deleted_at"], name: "index_people_on_deleted_at"
    t.index ["full_name", "number"], name: "index_people_on_full_name_and_number"
    t.index ["full_name"], name: "index_people_on_full_name"
    t.index ["number"], name: "index_people_on_number"
    t.index ["person_type", "full_name"], name: "index_people_on_person_type_and_full_name"
    t.index ["person_type", "number", "full_name"], name: "index_people_on_person_type_and_number_and_full_name"
    t.index ["person_type", "number"], name: "index_people_on_person_type_and_number"
    t.index ["person_type"], name: "index_people_on_person_type"
    t.index ["sex", "full_name", "number"], name: "index_people_on_sex_and_full_name_and_number"
    t.index ["sex"], name: "index_people_on_sex"
  end

  create_table "terminals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "state"
    t.string "terminal"
    t.integer "manager_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_terminals_on_deleted_at"
    t.index ["manager_id"], name: "index_terminals_on_manager_id"
    t.index ["state", "terminal"], name: "index_terminals_on_state_and_terminal"
    t.index ["state"], name: "index_terminals_on_state"
    t.index ["terminal"], name: "index_terminals_on_terminal"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 1
    t.string "number"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "terminal_id"
    t.datetime "deleted_at"
    t.index ["active"], name: "index_users_on_active"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["name", "username"], name: "index_users_on_name_and_username"
    t.index ["name"], name: "index_users_on_name"
    t.index ["terminal_id"], name: "index_users_on_terminal_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
