class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name, limit: 55, null: false
      t.string :acronym, limit: 5, null: false
      t.integer :iso_code, unique: true, null: false
      t.string :zone, limit: 45, null: true

      t.timestamps
    end
  end
end
