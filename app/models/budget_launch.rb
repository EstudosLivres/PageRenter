class BudgetLaunch < ActiveRecord::Base
  belongs_to :budget
  belongs_to :financial_transaction
end
