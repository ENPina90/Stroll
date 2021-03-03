# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_03_115926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ending_locations", force: :cascade do |t|
    t.bigint "walk_id", null: false
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["walk_id"], name: "index_ending_locations_on_walk_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "category"
    t.integer "cost"
    t.integer "significance"
    t.string "keywords"
    t.string "info"
    t.text "intro"
    t.text "content"
    t.text "facts"
    t.string "photo_url"
    t.string "photo_caption"
    t.string "sources"
    t.string "lang"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "location_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_notes_on_location_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "starred_locations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_starred_locations_on_location_id"
    t.index ["user_id"], name: "index_starred_locations_on_user_id"
  end

  create_table "starting_locations", force: :cascade do |t|
    t.bigint "walk_id", null: false
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["walk_id"], name: "index_starting_locations_on_walk_id"
  end

  create_table "stroll_locations", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "walk_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_stroll_locations_on_location_id"
    t.index ["walk_id"], name: "index_stroll_locations_on_walk_id"
  end

  create_table "stroll_settings", force: :cascade do |t|
    t.string "category"
    t.integer "significance"
    t.integer "cost"
    t.boolean "newness"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_stroll_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "walks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stroll_setting_id", null: false
    t.integer "significance"
    t.string "category"
    t.integer "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stroll_setting_id"], name: "index_walks_on_stroll_setting_id"
    t.index ["user_id"], name: "index_walks_on_user_id"
  end

  add_foreign_key "ending_locations", "walks"
  add_foreign_key "notes", "locations"
  add_foreign_key "notes", "users"
  add_foreign_key "starred_locations", "locations"
  add_foreign_key "starred_locations", "users"
  add_foreign_key "starting_locations", "walks"
  add_foreign_key "stroll_locations", "locations"
  add_foreign_key "stroll_locations", "walks"
  add_foreign_key "stroll_settings", "users"
  add_foreign_key "walks", "stroll_settings"
  add_foreign_key "walks", "users"
end
