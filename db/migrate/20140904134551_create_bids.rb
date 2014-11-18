class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :per_visitation, precision: 4, scale: 2, null: false
      t.decimal :per_foreign_interaction, precision: 4, scale: 2, null: false
      t.decimal :per_local_interaction, precision: 4, scale: 2, null: false
      t.decimal :per_conversion, precision: 4, scale: 2, null: false
      t.decimal :per_impression, precision: 4, scale: 2, null: true
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
