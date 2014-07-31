class Budget < ActiveRecord::Base
  belongs_to :currency
  belongs_to :campaign
  belongs_to :recurrence_period
  # TODO has_many financial_transaction trough BudgetLaunches

  # Custom validations
  validate :disable_last_budget, on: [:create] # TODO verify how does it work

  # Rails validations
  validates :value, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 1, :less_than => 100000000}, on: [:create, :update]
  validates :closed_date, presence: true, on: :update

  # Validates Associations
  validates :currency_id, presence: true, on: [:create]
  validates :campaign_id, presence: true, on: [:create]
  validates :recurrence_period_id, presence: true, on: [:create]

  # The budget have a history, so can't be UPDATED neither be DESTROYED
  def disable_last_budget
    last_budget = self.campaign.budgets.last
    unless last_budget.nil?
      last_budget.update(activated:false, closed_date:"#{Time.now()}")
      # TODO prevent to persist if the last budget couldn't be UPDATED
    end
  end

  # TODO activated significa que é o orçamento corrente este que o usuário está usando
  # TODO lembrar que os orçamentos nunca são editados, sempre são criados novos
end
