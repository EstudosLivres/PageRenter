class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      # Identifier for the user
      t.string :name, limit: 75, null: false

      # The date references
      t.datetime :launch_date, null: true
      t.datetime :end_date, null: true

      # Associations
      t.references :advertiser, index: true
      t.belongs_to :campaign_type

      t.timestamps
    end
  end
end
