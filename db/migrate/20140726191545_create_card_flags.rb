class CreateCardFlags < ActiveRecord::Migration
  def change
    create_table :card_flags do |t|
      t.string :name, limit: 30, null: false
      t.string :acronym, limit: 30, null: false

      t.timestamps
    end

    add_index :card_flags, :name, unique: true
    add_index :card_flags, :acronym, unique: true
  end
end
