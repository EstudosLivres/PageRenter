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

ActiveRecord::Schema.define(version: 20140605024546) do

  create_table "campaigns", force: true do |t|
    t.string   "name",                           limit: 50,  null: false
    t.string   "redirect_link",                  limit: 200, null: false
    t.string   "slogan",                         limit: 65
    t.string   "description",                    limit: 140
    t.string   "social_phrase",                  limit: 140
    t.integer  "advertiser_id"
    t.string   "advertising_piece_file_name"
    t.string   "advertising_piece_content_type"
    t.integer  "advertising_piece_file_size"
    t.datetime "advertising_piece_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["advertiser_id"], name: "index_campaigns_on_advertiser_id", using: :btree

  create_table "page_accounts", force: true do |t|
    t.string   "id_on_social", limit: 45, null: false
    t.string   "name",         limit: 75, null: false
    t.string   "category",     limit: 25, null: false
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_accounts_social_sessions", id: false, force: true do |t|
    t.integer "social_session_id"
    t.integer "page_account_id"
  end

  create_table "payment_methods", force: true do |t|
    t.string   "name",        limit: 50,  null: false
    t.string   "method_type", limit: 50
    t.string   "description", limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "name",         limit: 55
    t.boolean  "default_role",            null: false
    t.integer  "role_id",                 null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.string   "token",          limit: 50,  null: false
    t.string   "id_on_operator", limit: 45,  null: false
    t.string   "url_access",     limit: 140, null: false
    t.string   "tid",            limit: 45
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "receipts", ["transaction_id"], name: "index_receipts_on_transaction_id", using: :btree

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
    t.string   "gender",            limit: 10
    t.string   "locale",            limit: 5,  null: false
    t.integer  "count_friends",     limit: 8,  null: false
    t.integer  "user_id"
    t.integer  "social_network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.decimal  "value",                        precision: 9, scale: 2, null: false
    t.decimal  "decimal",                      precision: 9, scale: 2, null: false
    t.string   "currency",          limit: 30,                         null: false
    t.boolean  "banking",                                              null: false
    t.integer  "payment_method_id"
    t.integer  "payer_id"
    t.integer  "receiver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["payer_id"], name: "index_transactions_on_payer_id", using: :btree
  add_index "transactions", ["payment_method_id"], name: "index_transactions_on_payment_method_id", using: :btree
  add_index "transactions", ["receiver_id"], name: "index_transactions_on_receiver_id", using: :btree

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
