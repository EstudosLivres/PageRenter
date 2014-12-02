class Budget < ActiveRecord::Base
  # Associations
  belongs_to :currency
  belongs_to :campaign
  belongs_to :recurrence_period
  has_many :financial_transactions
  # TODO has_many financial_transaction trough BudgetLaunches

  # Custom validations
  before_validation :correct_format_for_values
  before_validation :disable_last_budget, on: [:create]

  # Rails validations
  validates :closed_date, presence: true, on: :update
  # The 100 means 1,00 or 1.00 on the Operator, it means 1 currency unity
  validates :value, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 100, :less_than => 1000000000}, on: [:create, :update]

  # Validates Associations
  validates :currency_id, presence: true, on: [:create]
  validates :campaign_id, presence: true, on: [:create]
  validates :recurrence_period_id, presence: true, on: [:create]

  # Return the "active" transaction
  def current_transaction
    self.financial_transactions.last
  end

  # =============================== Private methods for callbakcs ============================
  private
    # SetUp it attrs to it correct values_format
    def correct_format_for_values
      self.value = Currency.to_operator_str self.value
    end

    # The budget have a history, so can't be UPDATED neither be DESTROYED
    def disable_last_budget
      last_budget = self.campaign.budgets.last
      unless last_budget.nil?
        begin
          last_budget.update(activated:false, closed_date:"#{Time.now()}")
        rescue => e
          self.errors.messages.add(e.message)
        end
      end
    end
  # TODO activated significa que é o orçamento corrente este que o usuário está usando
  # TODO lembrar que os orçamentos nunca são editados, sempre são criados novos
end
