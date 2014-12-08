class Budget < ActiveRecord::Base
  # Associations
  belongs_to :currency
  belongs_to :campaign
  belongs_to :recurrence_period
  belongs_to :card_flag
  has_many :financial_transactions

  # Custom validations
  before_validation :get_operator_url
  before_validation :correct_format_for_values
  before_validation :disable_last_budget, on: [:create]

  # Rails validations
  validates :closed_date, presence: true, on: :update
  # The 100 means 1,00 or 1.00 on the Operator, it means 1 currency unity (it is mult 100 because the 100 are the cents, so 10*100 is just 10 R$/US$...)
  validates :value, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 50*100, less_than: 100000*100}, on: [:create, :update]

  # Validates Associations
  validates :currency_id, presence: true, on: [:create, :update]
  validates :campaign_id, presence: true, on: [:create, :update]
  validates :card_flag_id, presence: true, on: [:create, :update]
  validates :recurrence_period_id, presence: true, on: [:create, :update]

  # Return the "active" transaction
  def current_transaction
    transaction = self.financial_transactions.last
    if transaction.nil? then FinancialTransaction.new else transaction end
  end

  # Method to print the value on the masked form
  def operator_value_str
    return self.value if Rents::Currency.have_cents? self.value if self.value
    self.value*10 # it is to convert the int float, like 1.0 to 1.00
  end

  # ActiveRecord Get Method overwrite to print the real value, not the operator value
  def value
    # it is the real value, like 100, means R$1,00
    read_attribute(:value).to_f/100 if read_attribute(:value)
  end

  # =============================== Private methods for callbakcs ============================
  private
    # SetUp it attrs to it correct values_format
    def correct_format_for_values
      self.value.to_i
    end

    # The budget have a history, so can't be UPDATED neither be DESTROYED
    def disable_last_budget
      last_budget = self.campaign.budgets.last
      unless last_budget.nil?
        begin
          last_budget.update(active:false, closed_date:"#{Time.now()}")
        rescue => e
          self.errors.messages.add(e.message)
        end
      end
    end

    # SetUp it OperatorURL to be persisted
    def get_operator_url

    end

  # TODO active significa que é o orçamento corrente este que o usuário está usando
  # TODO lembrar que os orçamentos nunca são editados, sempre são criados novos
end
