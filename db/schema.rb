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

ActiveRecord::Schema.define(version: 2021_04_06_140935) do

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
    t.string "destination_local_goverment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id"
    t.bigint "manifest_id"
    t.index ["destination_local_goverment"], name: "index_manifest_people_on_destination_local_goverment"
    t.index ["destination_state", "destination_local_goverment"], name: "index_manifest_people_on_destination_and_lgt"
    t.index ["destination_state"], name: "index_manifest_people_on_destination_state"
    t.index ["manifest_id"], name: "index_manifest_people_on_manifest_id"
    t.index ["person_id", "destination_state"], name: "index_manifest_people_on_person_and_destination"
    t.index ["person_id", "manifest_id"], name: "index_manifest_people_on_person_id_and_manifest_id"
    t.index ["person_id"], name: "index_manifest_people_on_person_id"
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
    t.index ["company_id", "motor_id"], name: "index_manifests_on_company_id_and_motor_id"
    t.index ["company_id", "terminal_id", "motor_id"], name: "index_manifests_on_company_id_and_terminal_id_and_motor_id"
    t.index ["company_id", "terminal_id"], name: "index_manifests_on_company_id_and_terminal_id"
    t.index ["company_id"], name: "index_manifests_on_company_id"
    t.index ["deleted_at"], name: "index_manifests_on_deleted_at"
    t.index ["destination_state"], name: "index_manifests_on_destination_state"
    t.index ["motor_id"], name: "index_manifests_on_motor_id"
    t.index ["source_state", "destination_state"], name: "index_manifests_on_source_state_and_destination_state"
    t.index ["source_state"], name: "index_manifests_on_source_state"
    t.index ["terminal_id"], name: "index_manifests_on_terminal_id"
  end

  create_table "motors", force: :cascade do |t|
    t.string "model"
    t.integer "brand"
    t.string "color"
    t.integer "year"
    t.string "chasis_number"
    t.string "number_plate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "person_id"
    t.datetime "deleted_at"
    t.index ["brand", "model"], name: "index_motors_on_brand_and_model"
    t.index ["brand"], name: "index_motors_on_brand"
    t.index ["chasis_number"], name: "index_motors_on_chasis_number"
    t.index ["deleted_at"], name: "index_motors_on_deleted_at"
    t.index ["model"], name: "index_motors_on_model"
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
    t.index ["deleted_at"], name: "index_people_on_deleted_at"
    t.index ["full_name"], name: "index_people_on_full_name"
    t.index ["number"], name: "index_people_on_number"
    t.index ["person_type", "full_name"], name: "index_people_on_person_type_and_full_name"
    t.index ["person_type", "number", "full_name"], name: "index_people_on_person_type_and_number_and_full_name"
    t.index ["person_type", "number"], name: "index_people_on_person_type_and_number"
    t.index ["person_type"], name: "index_people_on_person_type"
  end

  create_table "terminals", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "state"
    t.string "local_goverment"
    t.integer "manager_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_terminals_on_deleted_at"
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
