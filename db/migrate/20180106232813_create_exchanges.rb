class CreateExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :exchanges do |t|
      t.string :name, null: false
      t.boolean :preferred, default: false, null: false

      t.timestamps
    end

    add_index :exchanges, :name
    add_index :exchanges, :preferred
  end
end
