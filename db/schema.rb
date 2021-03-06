# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150725012532) do

  create_table "chair_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chairs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "chairs_manager_id"
    t.string   "name_in_manager"
    t.integer  "chair_group_id"
  end

  add_index "chairs", ["chair_group_id"], name: "index_chairs_on_chair_group_id"
  add_index "chairs", ["chairs_manager_id", "name_in_manager"], name: "index_chairs_on_chairs_manager_id_and_name_in_manager"
  add_index "chairs", ["chairs_manager_id"], name: "index_chairs_on_chairs_manager_id"
  add_index "chairs", ["user_id"], name: "index_chairs_on_user_id"

  create_table "chairs_managers", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "available_chairs"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
