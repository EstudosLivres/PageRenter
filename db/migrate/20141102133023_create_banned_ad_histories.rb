class CreateBannedAdHistories < ActiveRecord::Migration
  def change
    create_table :banned_ad_histories do |t|
      t.string :reason, limit: 75, null: false
      t.string :description, limit: 140, null: false
      t.belongs_to :user, index: true, null: false
      t.belongs_to :ad, index: true, null: false

      t.timestamps
    end
  end
end
