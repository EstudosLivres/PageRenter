class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :name, limit: 50, null: false
      t.string :acronym, limit: 10, null: true
      t.string :description, limit: 45, null: true

      t.timestamps
    end
  end
end
