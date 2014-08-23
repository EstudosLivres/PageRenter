class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    create_join_table :ads, :segments
  end
end
