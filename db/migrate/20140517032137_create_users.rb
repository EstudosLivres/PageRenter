class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 55, null: false
      t.string :username, limit: 30, null: false
      t.string :email, limit: 55, unique: true, null: false
      t.column :locale, "char(5)", null: false
      t.column :pass_salt, "char(29)", null: true
      t.column :password, "char(60)", null: true
      t.string :access_token, unique: true, null: true

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
