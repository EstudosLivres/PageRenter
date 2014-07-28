class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.boolean :activated, null: false
      t.boolean :value, null: false
      t.string :close_date, null: true
      t.belongs_to :currency, index: true, null: false
      t.belongs_to :campaign, index: true, null: false
      t.belongs_to :recurrence_period, index: true, null: false

      t.timestamps
    end
  end
end
