class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :symbol
      t.string :asset_symbol
      t.string :asset_name
      t.string :quote_asset_symbol
      t.string :quote_asset_name

      t.belongs_to :exchange, foreign_key: true

      t.timestamps
    end

    add_index :coins, :symbol
    add_index :coins, :asset_symbol
    add_index :coins, :quote_asset_symbol
  end
end
