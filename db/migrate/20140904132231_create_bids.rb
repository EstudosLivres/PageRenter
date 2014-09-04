class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :visitation, :decimal, precision: 3, scale: 2, null: false
      t.decimal :impression, :decimal, precision: 3, scale: 2, null: true
      t.decimal :foreign_interactions, :decimal, precision: 3, scale: 2, null: false
      t.decimal :local_interactions, :decimal, precision: 3, scale: 2, null: false
      t.belongs_to :campaign, index: true
      t.belongs_to :currency, index: true

      t.timestamps
    end
  end
end