class CreateSocialSessionSegments < ActiveRecord::Migration
  def change
    create_table :social_session_segments do |t|
      t.belongs_to :segment, index: true, null: false
      t.belongs_to :social_session, index: true, null: true
      t.string :id_on_social, limit: 45, null: false

      t.timestamps
    end
  end
end
