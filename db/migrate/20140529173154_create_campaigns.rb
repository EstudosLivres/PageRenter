class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name, limit: 50, null: false
      t.string :redirect_link, limit: 200, null: false
      t.string :slogan, limit: 65, null: true
      t.string :description, limit: 140, null: true
      t.string :social_phrase, limit: 140, null: true
      t.references :advertiser, index: true

      t.timestamps
    end
  end
end
