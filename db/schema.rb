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

ActiveRecord::Schema[7.0].define(version: 2022_10_28_030939) do
  create_table "events", force: :cascade do |t|
    t.string "event_name"
    t.string "address"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float "price"
    t.text "description"
    t.string "tag"
    t.string "pictures"
    t.integer "available_spots"
    t.integer "occupied_spots"
    t.integer "organizer_id"
    t.string "applicants_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.text "bio"
    t.datetime "joined_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end