class CreateAdPricings < ActiveRecord::Migration
  def change
    create_table :ad_pricings do |t|
      t.float :value_paid_per_visitation
      t.belongs_to :campaign, index: true
      t.belongs_to :currency, index: true

      t.timestamps
    end
  end
end
