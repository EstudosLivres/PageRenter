class CreateAdPricings < ActiveRecord::Migration
  def change
    create_table :ad_pricings do |t|
      t.float :value_paid_per_visitationm, null: false
      t.belongs_to :campaign, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
