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

ActiveRecord::Schema.define(version: 20180107075931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "coin_histories", force: :cascade do |t|
    t.bigint "coin_id"
    t.integer "rank"
    t.float "price_usd"
    t.float "market_cap_usd"
    t.float "percent_change_1h"
    t.float "percent_change_24h"
    t.float "percent_change_7d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_coin_histories_on_coin_id"
    t.index ["market_cap_usd"], name: "index_coin_histories_on_market_cap_usd"
    t.index ["percent_change_1h"], name: "index_coin_histories_on_percent_change_1h"
    t.index ["percent_change_24h"], name: "index_coin_histories_on_percent_change_24h"
    t.index ["percent_change_7d"], name: "index_coin_histories_on_percent_change_7d"
    t.index ["price_usd"], name: "index_coin_histories_on_price_usd"
    t.index ["rank"], name: "index_coin_histories_on_rank"
  end

  create_table "coins", force: :cascade do |t|
    t.string "name", null: false
    t.string "symbol", null: false
    t.integer "rank"
    t.boolean "preferred", default: false, null: false
    t.float "price_usd"
    t.float "market_cap_usd"
    t.float "percent_change_1h"
    t.float "percent_change_24h"
    t.float "percent_change_7d"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_cap_usd"], name: "index_coins_on_market_cap_usd"
    t.index ["name"], name: "index_coins_on_name"
    t.index ["preferred"], name: "index_coins_on_preferred"
    t.index ["price_usd"], name: "index_coins_on_price_usd"
    t.index ["rank"], name: "index_coins_on_rank"
    t.index ["symbol"], name: "index_coins_on_symbol"
  end

  create_table "exchange_coins", force: :cascade do |t|
    t.bigint "exchange_id"
    t.bigint "coin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_exchange_coins_on_coin_id"
    t.index ["exchange_id"], name: "index_exchange_coins_on_exchange_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "preferred", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_exchanges_on_name"
    t.index ["preferred"], name: "index_exchanges_on_preferred"
  end

  add_foreign_key "coin_histories", "coins"
  add_foreign_key "exchange_coins", "coins"
  add_foreign_key "exchange_coins", "exchanges"
end
