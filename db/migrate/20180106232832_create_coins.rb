class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :symbol
      t.belongs_to :exchange, foreign_key: true

      t.timestamps
    end

    add_index :coins, :symbol
  end
end
