class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      # Internal control
      t.string :name, limit: 50, null: false

      # Based on facebook
      t.string :title, limit: 90, null: false #On the head title TAG
      t.string :description, limit: 200, null: true #The text on the POST

      # PageRenter purpose
      t.string :username, limit: 140, null: false # Goes on the Ad link (for Google SEO)
      t.string :social_phrase, limit: 140, null: true # example phrase to be used on social medias
      t.string :hash_tags, limit: 140, null: true # hash_tags separated by commons

      # Any Ad uses
      t.text :redirect_link, limit: 1240, null: false
      t.belongs_to :campaign

      t.timestamps
    end
  end
end
