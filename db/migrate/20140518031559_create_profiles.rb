class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name, limit: 55, null: true
      t.string :username, limit: 55, null: true
      t.boolean :default_role, null: false
      t.belongs_to :role, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
