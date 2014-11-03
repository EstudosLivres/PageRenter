class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :visitation, precision: 4, scale: 2, null: false
      t.decimal :impression, precision: 4, scale: 2, null: true
      t.decimal :foreign_interactions, precision: 4, scale: 2, null: false
      t.decimal :local_interactions, precision: 4, scale: 2, null: false
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
