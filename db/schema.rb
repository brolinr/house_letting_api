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

ActiveRecord::Schema.define(version: 2023_10_24_065439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amounts", force: :cascade do |t|
    t.decimal "price"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_amounts_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.integer "feedback_type", default: 0
  end

  create_table "properties", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "location"
    t.string "owner_phone"
    t.string "owner_whatsapp"
    t.string "owner_email"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "poll_url"
    t.string "month"
    t.string "ecocash_number"
    t.bigint "user_id", null: false
    t.integer "payment_status", default: 0
    t.integer "fee", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
  end

  add_foreign_key "amounts", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "properties", "users"
  add_foreign_key "subscriptions", "users"
end
