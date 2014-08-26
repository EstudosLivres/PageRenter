class CreateSocialSessionSegments < ActiveRecord::Migration
  def change
    create_table :social_session_segments do |t|
      t.string :id_on_social, limit: 45, unique: true, null: false
      t.integer :social_session_id, index: true, unique: true, null: true

      t.timestamps
    end

    add_index :social_session_segments, :id_on_social, unique: true
    add_index :social_session_segments, :social_session_id, unique: true
    create_join_table :social_session_segments, :segments
  end
end
