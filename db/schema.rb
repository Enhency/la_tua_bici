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

ActiveRecord::Schema.define(version: 20141022200522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_shops", force: true do |t|
    t.string   "name"
    t.string   "photo"
    t.text     "description"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "mon_wt"
    t.string   "mon_lt"
    t.string   "tue_wt"
    t.string   "tue_lt"
    t.string   "wed_wt"
    t.string   "wed_lt"
    t.string   "thu_wt"
    t.string   "thu_lt"
    t.string   "fri_wt"
    t.string   "fri_lt"
    t.string   "sat_wt"
    t.string   "sat_lt"
    t.string   "sun_wt"
    t.string   "sun_lt"
    t.string   "description_typetext"
    t.text     "description_fulltext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
