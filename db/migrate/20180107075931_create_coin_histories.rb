class CreateCoinHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_histories do |t|
      t.belongs_to :coin, foreign_key: true
      t.integer :rank
      t.float :price_usd
      t.float :market_cap_usd
      t.float :percent_change_1h
      t.float :percent_change_24h
      t.float :percent_change_7d

      t.timestamps
    end

    add_index :coin_histories, :rank
    add_index :coin_histories, :price_usd
    add_index :coin_histories, :market_cap_usd
    add_index :coin_histories, :percent_change_1h
    add_index :coin_histories, :percent_change_24h
    add_index :coin_histories, :percent_change_7d
  end
end
