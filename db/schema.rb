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

ActiveRecord::Schema.define(version: 20180106232902) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coin_prices", force: :cascade do |t|
    t.float "price"
    t.bigint "coin_id"
    t.bigint "exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_coin_prices_on_coin_id"
    t.index ["exchange_id"], name: "index_coin_prices_on_exchange_id"
    t.index ["price"], name: "index_coin_prices_on_price"
  end

  create_table "coins", force: :cascade do |t|
    t.string "symbol"
    t.string "asset_symbol"
    t.string "asset_name"
    t.string "quote_asset_symbol"
    t.string "quote_asset_name"
    t.bigint "exchange_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_symbol"], name: "index_coins_on_asset_symbol"
    t.index ["exchange_id"], name: "index_coins_on_exchange_id"
    t.index ["quote_asset_symbol"], name: "index_coins_on_quote_asset_symbol"
    t.index ["symbol"], name: "index_coins_on_symbol"
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "coin_prices", "coins"
  add_foreign_key "coin_prices", "exchanges"
  add_foreign_key "coins", "exchanges"
end
