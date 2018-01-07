class CreateExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :exchanges do |t|
      t.string :name, null: false
      t.boolean :preferred, default: false, null: false

      t.timestamps
    end
  end
end
