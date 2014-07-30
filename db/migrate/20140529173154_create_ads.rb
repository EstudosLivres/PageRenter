class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name, limit: 50, null: false
      t.string :title, limit: 50, null: false
      t.string :description, limit: 140, null: false
      t.string :social_phrase, limit: 140, null: true
      t.string :redirect_link, limit: 200, null: false
      t.belongs_to :campaign

      t.timestamps
    end
  end
end
