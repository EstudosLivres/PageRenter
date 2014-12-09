class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :per_visitation, null: false
      t.integer :per_foreign_interaction, null: false
      t.integer :per_local_interaction, null: false
      t.integer :per_conversion, null: false
      t.integer :per_impression, null: true
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
