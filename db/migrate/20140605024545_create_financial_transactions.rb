class CreateFinancialTransactions < ActiveRecord::Migration
  def change
    create_table :financial_transactions do |t|
      # It value must be in integer syntax, like the operator requires (int and last 2 characters are the cents)
      t.string :value, limit: 10, null: false
      # Default is false = user_payment, true = user_receipt
      t.boolean :withdraw, null: false
      # Sent to the Gateway, but is saved just it string name
      t.string :payment_method, limit: 50, null: false
      # It reference on the Gateway
      t.integer :remote_id, null: false

      # Associations
      t.belongs_to :user, index: true, null: false
      t.belongs_to :budget, index: true, null: false
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
