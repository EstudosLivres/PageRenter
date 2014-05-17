class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 55, null: false
      t.string :nick, limit: 30, null: false
      t.string :email, limit: 55, null: false
      t.column :locale, "char(5)", null: false
      t.column :password_hash, "char(60)", null: true

      t.timestamps
    end
  end
end
