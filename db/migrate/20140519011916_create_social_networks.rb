class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :name, limit: 50, null: false
      t.string :username, limit: 30, null: false
      t.string :acronym, limit: 10, null: false
      t.boolean :monitoring, null: false
      t.string :description, limit: 50, null: true

      t.timestamps
    end
  end
end
