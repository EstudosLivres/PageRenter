class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :visitation
      t.float :impression
      t.decimal :foreign_interactions
      t.decimal :local_interactions
      t.belongs_to :ad, index: true
      t.belongs_to :currency, index: true

      t.timestamps
    end
  end
end
