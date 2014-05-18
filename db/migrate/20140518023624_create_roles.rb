class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 15, unique: true, null: false

      t.timestamps
    end
  end
end
