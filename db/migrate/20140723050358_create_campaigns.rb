class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name, limit: 75, null: false
      t.datetime :launch_date, null: true
      t.datetime :end_date, null: true
      t.references :advertiser, index: true

      t.timestamps
    end
  end
end
