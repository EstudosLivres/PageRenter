class CreateSocialSessionSegments < ActiveRecord::Migration
  def change
    create_table :social_session_segments do |t|
      t.belongs_to :social_session, index: true, null: true
      t.string :id_on_social, limit: 45, null: false

      t.timestamps
    end

    create_join_table :segments, :social_session_segments
  end
end
