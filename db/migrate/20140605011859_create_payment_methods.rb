class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :name, limit: 50, null: false
      t.string :method_type, limit: 50, null: true
      t.string :description, limit: 140, null: true

      t.timestamps
    end
  end
end
