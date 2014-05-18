class CreateUserProfilePerRoles < ActiveRecord::Migration
  def change
    create_table :user_profile_per_roles do |t|
      t.string :name, limit: 55, null: true
      t.boolean :default_role, null: false
      t.belongs_to :role
      t.belongs_to :user

      t.timestamps
    end
  end
end
