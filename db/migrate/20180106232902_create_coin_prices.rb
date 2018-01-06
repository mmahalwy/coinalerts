class CreateCoinPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_prices do |t|
      t.float :price
      t.belongs_to :coin, foreign_key: true
      t.belongs_to :exchange, foreign_key: true

      t.timestamps
    end

    add_index :coin_prices, :price
  end
end
