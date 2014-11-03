class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      # Internal control
      t.string :name, limit: 50, null: false

      # Based on facebook
      t.string :headline, limit: 25, null: false
      t.string :title, limit: 90, null: false
      t.string :description, limit: 200, null: true
      t.string :audience, limit: 140, null: true

      # PageRenter purpose
      t.string :username, limit: 140, null: false # Goes on the Ad link (for Google SEO)
      t.string :social_phrase, limit: 140, null: true # example phrase to be used on social medias

      # Any Ad uses
      t.text :redirect_link, limit: 1240, null: false
      t.belongs_to :campaign

      t.timestamps
    end
  end
end
