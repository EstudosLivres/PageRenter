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

ActiveRecord::Schema.define(version: 20140823131330) do

  create_table "ad_history_states", force: true do |t|
    t.integer  "ad_id"
    t.integer  "ad_state_id"
    t.string   "reason",      limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ad_pricings", force: true do |t|
    t.float    "value_paid_per_visitation", limit: 24, null: false
    t.integer  "campaign_id",                          null: false
    t.integer  "currency_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_pricings", ["campaign_id"], name: "index_ad_pricings_on_campaign_id", using: :btree
  add_index "ad_pricings", ["currency_id"], name: "index_ad_pricings_on_currency_id", using: :btree

  create_table "ad_states", force: true do |t|
    t.string   "name",        limit: 40,  null: false
    t.string   "msg",         limit: 15,  null: false
    t.string   "description", limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", force: true do |t|
    t.string   "name",                limit: 50,  null: false
    t.string   "title",               limit: 50,  null: false
    t.string   "username",            limit: 140, null: false
    t.string   "description",         limit: 140, null: false
    t.string   "social_phrase",       limit: 140
    t.text     "redirect_link",                   null: false
    t.integer  "campaign_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads_segments", id: false, force: true do |t|
    t.integer "ad_id",      null: false
    t.integer "segment_id", null: false
  end

  create_table "budget_launches", force: true do |t|
    t.integer  "budget_id"
    t.integer  "financial_transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budget_launches", ["budget_id"], name: "index_budget_launches_on_budget_id", using: :btree
  add_index "budget_launches", ["financial_transaction_id"], name: "index_budget_launches_on_financial_transaction_id", using: :btree

  create_table "budgets", force: true do |t|
    t.boolean  "activated",                                               null: false
    t.decimal  "value",                           precision: 8, scale: 2, null: false
    t.string   "closed_date",          limit: 30
    t.integer  "currency_id",                                             null: false
    t.integer  "campaign_id",                                             null: false
    t.integer  "recurrence_period_id",                                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budgets", ["campaign_id"], name: "index_budgets_on_campaign_id", using: :btree
  add_index "budgets", ["currency_id"], name: "index_budgets_on_currency_id", using: :btree
  add_index "budgets", ["recurrence_period_id"], name: "index_budgets_on_recurrence_period_id", using: :btree

  create_table "campaign_types", force: true do |t|
    t.string   "name",        limit: 35,  null: false
    t.string   "description", limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: true do |t|
    t.string   "name",          limit: 75, null: false
    t.datetime "launch_date"
    t.datetime "end_date"
    t.integer  "advertiser_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["advertiser_id"], name: "index_campaigns_on_advertiser_id", using: :btree

  create_table "currencies", force: true do |t|
    t.string   "name",       limit: 55, null: false
    t.string   "acronym",    limit: 5,  null: false
    t.integer  "iso_code",              null: false
    t.string   "zone",       limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financial_transactions", force: true do |t|
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

  add_index "financial_transactions", ["payer_id"], name: "index_financial_transactions_on_payer_id", using: :btree
  add_index "financial_transactions", ["payment_method_id"], name: "index_financial_transactions_on_payment_method_id", using: :btree
  add_index "financial_transactions", ["receiver_id"], name: "index_financial_transactions_on_receiver_id", using: :btree

  create_table "page_accounts", force: true do |t|
    t.string   "id_on_social",           limit: 45, null: false
    t.string   "name",                   limit: 75, null: false
    t.string   "category",               limit: 25, null: false
    t.integer  "followers",              limit: 8,  null: false
    t.integer  "local_interactions",                null: false
    t.string   "local_interaction_id",   limit: 55, null: false
    t.integer  "foreign_interactions",              null: false
    t.string   "foreign_interaction_id", limit: 55, null: false
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
    t.string   "name",                limit: 55
    t.string   "username",            limit: 55
    t.boolean  "default_role",                   null: false
    t.integer  "role_id",                        null: false
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.string   "token",                     limit: 50,  null: false
    t.string   "id_on_operator",            limit: 45,  null: false
    t.string   "url_access",                limit: 140, null: false
    t.string   "tid",                       limit: 45
    t.integer  "financial_transactions_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "receipts", ["financial_transactions_id"], name: "index_receipts_on_financial_transactions_id", using: :btree

  create_table "recurrence_periods", force: true do |t|
    t.string   "name",        limit: 15, null: false
    t.string   "description", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 15, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "segments", force: true do |t|
    t.string   "name",        limit: 75,  null: false
    t.string   "description", limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_networks", force: true do |t|
    t.string   "name",        limit: 50, null: false
    t.string   "acronym",     limit: 10
    t.string   "username",    limit: 25, null: false
    t.boolean  "implemented",            null: false
    t.boolean  "just_share",             null: false
    t.string   "description", limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_session_segments", force: true do |t|
    t.integer  "segment_id",                   null: false
    t.integer  "social_session_id"
    t.string   "id_on_social",      limit: 45, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_session_segments", ["segment_id"], name: "index_social_session_segments_on_segment_id", using: :btree
  add_index "social_session_segments", ["social_session_id"], name: "index_social_session_segments_on_social_session_id", using: :btree

  create_table "social_sessions", force: true do |t|
    t.string   "id_on_social",           limit: 45, null: false
    t.string   "name",                   limit: 65, null: false
    t.string   "username",               limit: 45, null: false
    t.string   "email",                  limit: 55, null: false
    t.string   "gender",                 limit: 10
    t.string   "locale",                 limit: 5,  null: false
    t.integer  "friend_count",           limit: 8,  null: false
    t.integer  "local_interactions",                null: false
    t.string   "local_interaction_id",   limit: 55, null: false
    t.integer  "foreign_interactions",              null: false
    t.string   "foreign_interaction_id", limit: 55, null: false
    t.integer  "user_id"
    t.integer  "social_network_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",         limit: 55, null: false
    t.string   "username",     limit: 30, null: false
    t.string   "email",        limit: 55, null: false
    t.string   "locale",       limit: 5,  null: false
    t.string   "pass_salt",    limit: 29
    t.string   "password",     limit: 60
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
