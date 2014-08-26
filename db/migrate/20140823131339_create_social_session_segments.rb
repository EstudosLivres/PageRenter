class CreateSocialSessionSegments < ActiveRecord::Migration
  def change
    create_table :social_session_segments do |t|
      t.string :id_on_social, limit: 45, null: false
      t.belongs_to :social_session, index: true, null: true

      t.timestamps
    end

    add_index :social_session_segments, :id_on_social, unique: true
    create_join_table :social_session_segments, :segments
  end
end
