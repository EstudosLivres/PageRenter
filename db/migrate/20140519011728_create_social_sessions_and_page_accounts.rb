class CreateSocialSessionsAndPageAccounts < ActiveRecord::Migration
  def change
    create_table :social_sessions do |t|
      t.string :id_on_social, limit: 45, null: false
      t.string :name, limit: 65, null: false
      t.string :username, limit: 45, null: false
      t.string :email, limit: 55, null: false
      t.string :gender, limit: 10, null: true
      t.column :locale, "char(5)", null: false
      t.column :friend_count, "BIGINT", null: false
      t.integer :local_interactions, null: false # Like, comments...
      t.string :local_interaction_id, limit:55, null: false # Like, comments...
      t.integer :foreign_interactions, null: false # Share, retweet....
      t.string :foreign_interaction_id, limit:55, null: false # Like, comments...
      t.belongs_to :user
      t.belongs_to :social_network

      t.timestamps
    end

    create_table :page_accounts do |t|
      t.string :id_on_social, limit: 45, null: false
      t.string :name, limit: 75, null: false
      t.string :category, limit: 25, null: false
      t.column :followers, "BIGINT", null: false
      t.integer :local_interactions, null: false # Like, comments...
      t.string :local_interaction_id, limit:55, null: false # Like, comments...
      t.integer :foreign_interactions, null: false # Share, retweet....
      t.string :foreign_interaction_id, limit:55, null: false # Like, comments...
      t.string :access_token, limit: 255, null: true

      t.timestamps
    end

    create_table :page_accounts_social_sessions, id: false do |t|
      t.belongs_to :social_session
      t.belongs_to :page_account
    end
  end
end
