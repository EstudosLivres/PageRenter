class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :visitation, null: false
      t.float :impressions, null: false
      t.belongs_to :campaign, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
