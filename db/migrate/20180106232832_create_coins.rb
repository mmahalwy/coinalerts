class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name, null: false
      t.string :symbol, null: false
      t.integer :rank
      t.boolean :preferred, default: false, null: false
      t.float :price_usd
      t.float :market_cap_usd
      t.float :percent_change_1h
      t.float :percent_change_24h
      t.float :percent_change_7d

      t.timestamps
    end

    add_index :coins, :symbol
    add_index :coins, :rank
    add_index :coins, :name
    add_index :coins, :preferred
    add_index :coins, :price_usd
    add_index :coins, :market_cap_usd
  end
end