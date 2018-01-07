class AddCoinmarketcapIdToCoins < ActiveRecord::Migration[5.1]
  def change
    add_column :coins, :coinmarketcap_id, :string
  end
end
