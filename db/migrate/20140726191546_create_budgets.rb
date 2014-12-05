class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.boolean :activated, null: false
      t.decimal :value, precision: 8, scale: 2, null: false
      t.datetime :closed_date, null: true
      t.string :operator_url, limit: 140, null: true
      t.belongs_to :currency, index: true, null: false
      t.belongs_to :campaign, index: true, null: false
      t.belongs_to :recurrence_period, index: true, null: false

      t.timestamps
    end
  end
end
