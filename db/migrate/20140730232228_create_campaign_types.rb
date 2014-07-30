class CreateCampaignTypes < ActiveRecord::Migration
  def change
    create_table :campaign_types do |t|
      t.string :name, limit: 35, null: false
      t.string :description, limit: 140, null: true

      t.timestamps
    end
  end
end
