class CreateShorterLinks < ActiveRecord::Migration
  def change
    create_table :shorter_links do |t|
      t.string :link, limit: 60, null: false
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end

    add_index :shorter_links, :link, unique: true
  end
end
