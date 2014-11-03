class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :name, limit: 100, null: false
      t.string :description, limit: 200, null: true
      t.belongs_to :user, null: false

      t.timestamps
    end

    add_index :segments, :name, unique: true
    create_join_table :ads, :segments
  end
end
