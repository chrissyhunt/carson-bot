# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171229013226) do

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "location_id"
    t.integer "type_id"
    t.boolean "perishable"
    t.string "condition_status"
    t.string "condition_notes"
    t.string "registration_code"
    t.float "value"
    t.string "size"
    t.string "weight"
    t.date "date_acquired"
    t.string "source"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
  end

  create_table "shopping_list", force: :cascade do |t|
    t.integer "user_id"
    t.integer "item_id"
    t.string "notes"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
