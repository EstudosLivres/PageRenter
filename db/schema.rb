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

ActiveRecord::Schema.define(version: 20141211182214) do

  create_table "accesses", force: true do |t|
    t.boolean  "converted",  default: false, null: false
    t.boolean  "recurrent",  default: false, null: false
    t.integer  "ad_id",                      null: false
    t.integer  "profile_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accesses", ["ad_id"], name: "index_accesses_on_ad_id", using: :btree
  add_index "accesses", ["profile_id"], name: "index_accesses_on_profile_id", using: :btree

  create_table "ad_history_states", force: true do |t|
    t.integer  "ad_id",       null: false
    t.integer  "ad_state_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ad_states", force: true do |t|
    t.string   "name",        limit: 40,  null: false
    t.string   "msg",         limit: 40,  null: false
    t.string   "description", limit: 140
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", force: true do |t|
    t.string   "name",                limit: 50,  null: false
    t.string   "title",               limit: 90,  null: false
    t.string   "description",         limit: 200
    t.string   "username",            limit: 140, null: false
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

  create_table "banned_ad_histories", force: true do |t|
    t.string   "reason",      limit: 75,  null: false
    t.string   "description", limit: 140, null: false
    t.integer  "user_id",                 null: false
    t.integer  "ad_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banned_ad_histories", ["ad_id"], name: "index_banned_ad_histories_on_ad_id", using: :btree
  add_index "banned_ad_histories", ["user_id"], name: "index_banned_ad_histories_on_user_id", using: :btree

  create_table "bids", force: true do |t|
    t.integer  "per_visitation",          null: false
    t.integer  "per_foreign_interaction", null: false
    t.integer  "per_local_interaction",   null: false
    t.integer  "per_conversion",          null: false
    t.integer  "per_impression"
    t.boolean  "active",                  null: false
    t.datetime "closed_date"
    t.integer  "ad_id",                   null: false
    t.integer  "currency_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["ad_id"], name: "index_bids_on_ad_id", using: :btree
  add_index "bids", ["currency_id"], name: "index_bids_on_currency_id", using: :btree

  create_table "budgets", force: true do |t|
    t.boolean  "active",                         null: false
    t.integer  "value",                limit: 8, null: false
    t.datetime "closed_date"
    t.integer  "currency_id",                    null: false
    t.integer  "campaign_id",                    null: false
    t.integer  "card_flag_id",                   null: false
    t.integer  "recurrence_period_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budgets", ["campaign_id"], name: "index_budgets_on_campaign_id", using: :btree
  add_index "budgets", ["card_flag_id"], name: "index_budgets_on_card_flag_id", using: :btree
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

  create_table "card_flags", force: true do |t|
    t.string   "name",       limit: 30, null: false
    t.string   "acronym",    limit: 30, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "card_flags", ["acronym"], name: "index_card_flags_on_acronym", unique: true, using: :btree
  add_index "card_flags", ["name"], name: "index_card_flags_on_name", unique: true, using: :btree

  create_table "currencies", force: true do |t|
    t.string   "name",       limit: 55, null: false
    t.string   "acronym",    limit: 5,  null: false
    t.integer  "iso_code",              null: false
    t.string   "zone",       limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "financial_transactions", force: true do |t|
    t.integer  "value",          limit: 8,   null: false
    t.boolean  "withdraw",                   null: false
    t.string   "payment_method", limit: 50,  null: false
    t.integer  "remote_id",                  null: false
    t.string   "status_name",    limit: 25,  null: false
    t.integer  "status_code",                null: false
    t.string   "operator_url",   limit: 140
    t.integer  "payer"
    t.integer  "receiver"
    t.integer  "budget_id"
    t.integer  "currency_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "financial_transactions", ["budget_id"], name: "index_financial_transactions_on_budget_id", using: :btree
  add_index "financial_transactions", ["currency_id"], name: "index_financial_transactions_on_currency_id", using: :btree

  create_table "page_accounts", force: true do |t|
    t.string   "id_on_social",           limit: 45, null: false
    t.string   "name",                   limit: 75, null: false
    t.string   "category",               limit: 25
    t.integer  "followers_counter",      limit: 8
    t.integer  "local_interactions"
    t.string   "local_interaction_id",   limit: 55
    t.integer  "foreign_interactions"
    t.string   "foreign_interaction_id", limit: 55
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_accounts_social_sessions", id: false, force: true do |t|
    t.integer "social_session_id"
    t.integer "page_account_id"
  end

  create_table "profiles", force: true do |t|
    t.string   "name",                limit: 55
    t.string   "username",            limit: 55
    t.boolean  "default_role",                   null: false
    t.integer  "role_id",                        null: false
    t.integer  "user_id",                        null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recurrence_periods", force: true do |t|
    t.string   "name",        limit: 15, null: false
    t.string   "description", limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",       limit: 55, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "segments", force: true do |t|
    t.string   "name",        limit: 100, null: false
    t.string   "description", limit: 200
    t.integer  "user_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "segments", ["name"], name: "index_segments_on_name", unique: true, using: :btree

  create_table "segments_social_session_segments", id: false, force: true do |t|
    t.integer "social_session_segment_id", null: false
    t.integer "segment_id",                null: false
  end

  create_table "shorter_links", force: true do |t|
    t.string   "link",       limit: 60, null: false
    t.integer  "ad_id",                 null: false
    t.integer  "user_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shorter_links", ["ad_id"], name: "index_shorter_links_on_ad_id", using: :btree
  add_index "shorter_links", ["link"], name: "index_shorter_links_on_link", unique: true, using: :btree
  add_index "shorter_links", ["user_id"], name: "index_shorter_links_on_user_id", using: :btree

  create_table "social_interactions", force: true do |t|
    t.string   "external_id",       limit: 45, null: false
    t.string   "type",              limit: 45, null: false
    t.integer  "social_session_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_interactions", ["social_session_id"], name: "index_social_interactions_on_social_session_id", using: :btree

  create_table "social_networks", force: true do |t|
    t.string   "name",        limit: 50, null: false
    t.string   "username",    limit: 30, null: false
    t.string   "acronym",     limit: 10, null: false
    t.boolean  "implemented",            null: false
    t.boolean  "monitoring",             null: false
    t.boolean  "just_share",             null: false
    t.string   "description", limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_session_segments", force: true do |t|
    t.string   "id_on_social",      limit: 45, null: false
    t.integer  "social_session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_session_segments", ["id_on_social"], name: "index_social_session_segments_on_id_on_social", unique: true, using: :btree
  add_index "social_session_segments", ["social_session_id"], name: "index_social_session_segments_on_social_session_id", using: :btree

  create_table "social_sessions", force: true do |t|
    t.string   "id_on_social",           limit: 45, null: false
    t.string   "name",                   limit: 65, null: false
    t.string   "username",               limit: 45, null: false
    t.string   "email",                  limit: 55, null: false
    t.string   "gender",                 limit: 10
    t.string   "locale",                 limit: 5,  null: false
    t.string   "access_token"
    t.integer  "friends_counter",        limit: 8
    t.integer  "local_interactions"
    t.string   "local_interaction_id",   limit: 55
    t.integer  "foreign_interactions"
    t.string   "foreign_interaction_id", limit: 55
    t.integer  "user_id",                           null: false
    t.integer  "social_network_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                   limit: 55
    t.string   "username",               limit: 45
    t.string   "email",                             default: "", null: false
    t.string   "locale",                 limit: 5
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
