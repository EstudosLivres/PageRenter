class CreateSocialSessionSegments < ActiveRecord::Migration
  def change
    create_table :social_session_segments do |t|
      t.belongs_to :social_session, index: true, unique:true, null: true
      t.string :id_on_social, limit: 45, unique:true, null: false

      t.timestamps
    end

    create_join_table :social_session_segments, :segments
  end
end
