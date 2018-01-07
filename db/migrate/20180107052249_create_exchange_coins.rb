class CreateExchangeCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_coins do |t|
      t.belongs_to :exchange, foreign_key: true
      t.belongs_to :coin, foreign_key: true
      t.string :symbol, null: false
      t.string :asset_symbol, null: false
      t.string :asset_name, null: false
      t.string :quote_asset_symbol, null: false
      t.string :quote_asset_name, null: false

      t.timestamps
    end

    add_index :exchange_coins, :symbol
    add_index :exchange_coins, :asset_symbol
    add_index :exchange_coins, :quote_asset_symbol
  end
end
