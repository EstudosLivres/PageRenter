class CreateFinancialTransactions < ActiveRecord::Migration
  def change
    create_table :financial_transactions do |t|
      # It value is an integer, but it real value is it /100, like 100 means R$ 1,00
      t.integer :value, limit: 8, null: false
      # Default is false = user_payment, true = user_receipt
      t.boolean :withdraw, null: false
      # Sent to the Gateway, but is saved just it string name
      t.string :payment_method, limit: 50, null: false
      # ID on the Gateway, on the RentS it is the RID
      t.integer :remote_id, null: false
      # It status_name on the Gateway
      t.string :status_name, limit: 25, null: false
      # It status_code on the Gateway
      t.integer :status_code, null: false
      # The URL to be charged on the operator
      t.string :operator_url, limit: 140, null: true

      # CustomAssociations
      t.integer :payer, index: true, null: true
      t.integer :receiver, index: true, null: true

      # StandardAssociations
      t.belongs_to :budget, index: true, null: true
      t.belongs_to :currency, index: true, null: false

      t.timestamps
    end
  end
end
