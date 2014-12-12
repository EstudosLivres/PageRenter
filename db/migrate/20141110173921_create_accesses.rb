class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.boolean :converted, default: false, null: false
      t.boolean :recurrent, default: false, null: false
      t.belongs_to :ad, index: true, null: false
      t.belongs_to :profile, index: true, null: false

      t.timestamps
    end
  end
end
