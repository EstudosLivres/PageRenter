class CreateBudgetLaunches < ActiveRecord::Migration
  def change
    create_table :budget_launches do |t|
      t.belongs_to :budget, index: true
      t.belongs_to :financial_transaction, index: true

      t.timestamps
    end
  end
end
