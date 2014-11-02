class CreateSocialInteractions < ActiveRecord::Migration
  def change
    create_table :social_interactions do |t|
      t.string :external_id, limit: 45, null: false
      t.string :type, limit: 45, null: false
      t.belongs_to :social_session, index: true, null: false

      t.timestamps
    end
  end
end
