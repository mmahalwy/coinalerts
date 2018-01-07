class CreateExchangeCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :exchange_coins do |t|
      t.belongs_to :exchange, foreign_key: true
      t.belongs_to :coin, foreign_key: true

      t.timestamps
    end
  end
end
