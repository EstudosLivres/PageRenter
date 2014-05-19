class CreateSocialSessions < ActiveRecord::Migration
  def change
    create_table :social_sessions do |t|
      t.string :id_on_social, limit: 45, null: false
      t.string :name, limit: 65, null: false
      t.string :username, limit: 45, null: false
      t.string :email, limit: 55, null: false
      t.string :gender, limit: 10, null: false
      t.column :locale, "char(5)", null: false
      t.column :count_friends, "BIGINT", null: false
      t.belongs_to :user
      t.belongs_to :social_network

      t.timestamps
    end
  end
end
