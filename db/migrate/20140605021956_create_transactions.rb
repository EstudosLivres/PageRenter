class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :value, :decimal, precision: 9, scale: 2, null: false
      t.string :currency, limit: 30, null: false
      t.boolean :banking, null: false
      t.belongs_to :payment_method, index: true
      t.references :payer, index: true
      t.references :receiver, index: true

      t.timestamps
    end
  end
end
