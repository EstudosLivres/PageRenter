class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :token, limit: 50, null: false
      t.string :id_on_operator, limit: 45, null: false
      t.string :url_access, limit: 140, null: false
      t.string :tid, limit: 45, null: true
      t.belongs_to :transaction, index: true

      t.timestamps
    end
  end
end
