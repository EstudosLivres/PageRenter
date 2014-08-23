class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :name, limit: 75, null: false
      t.string :description, limit: 140, null: true

      t.timestamps
    end

    create_join_table :ads, :segments
  end
end
