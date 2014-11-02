class CreateSocialSessionsAndPageAccounts < ActiveRecord::Migration
  def change
    create_table :social_sessions do |t|
      # Attrs like user attrs
      t.string :id_on_social, limit: 45, null: false
      t.string :name, limit: 65, null: false
      t.string :username, limit: 45, null: false
      t.string :email, limit: 55, null: false
      t.string :gender, limit: 10, null: true
      t.column :locale, "char(5)", null: false

      # Dynamic calls from the social network (must be updated after it creation)
      t.string :access_token, null: true
      t.column :friends_counter, "BIGINT", null: true
      t.integer :local_interactions, null: true # Like, comments...
      t.string :local_interaction_id, limit:55, null: true # Like, comments...
      t.integer :foreign_interactions, null: true # Share, retweet....
      t.string :foreign_interaction_id, limit:55, null: true # Like, comments...
      t.belongs_to :user, null: false
      t.belongs_to :social_network, null: false

      t.timestamps
    end

    create_table :page_accounts do |t|
      # Main attrs
      t.string :id_on_social, limit: 45, null: false
      t.string :name, limit: 75, null: false

      # Useful but not mandatory attrs
      t.string :category, limit: 25, null: true
      t.column :followers_counter, "BIGINT", null: true
      t.integer :local_interactions, null: true # Like, comments...
      t.string :local_interaction_id, limit:55, null: true # Like, comments...
      t.integer :foreign_interactions, null: true # Share, retweet....
      t.string :foreign_interaction_id, limit:55, null: true # Like, comments...

      t.timestamps
    end

    create_table :page_accounts_social_sessions, id: false do |t|
      t.belongs_to :social_session
      t.belongs_to :page_account
    end
  end
end
