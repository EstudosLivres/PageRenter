class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.boolean :converted, default: false, null: false
      t.string :remote_id, limit: 45, null: true
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :profile, index: true, null: false
      t.belongs_to :social_network, null: true

      t.timestamps
    end
  end
end
