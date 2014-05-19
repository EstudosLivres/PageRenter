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

ActiveRecord::Schema.define(version: 20140519011916) do

  create_table "profiles", force: true do |t|
    t.string   "name",         limit: 55
    t.boolean  "default_role",            null: false
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 15, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_networks", force: true do |t|
    t.string   "name",        limit: 50, null: false
    t.string   "acronym",     limit: 10
    t.string   "description", limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_sessions", force: true do |t|
    t.string   "id_on_social",      limit: 45, null: false
    t.string   "name",              limit: 65, null: false
    t.string   "username",          limit: 45, null: false
    t.string   "email",             limit: 55, null: false
    t.string   "gender",            limit: 10, null: false
    t.string   "locale",            limit: 5,  null: false
    t.integer  "count_friends",     limit: 8,  null: false
    t.integer  "user_id"
    t.integer  "social_network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",         limit: 55, null: false
    t.string   "nick",         limit: 30, null: false
    t.string   "email",        limit: 55, null: false
    t.string   "locale",       limit: 5,  null: false
    t.string   "pass_salt",    limit: 29
    t.string   "password",     limit: 60
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
