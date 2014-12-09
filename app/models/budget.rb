class Budget < ActiveRecord::Base
  # Associations
  belongs_to :currency
  belongs_to :campaign
  belongs_to :recurrence_period
  belongs_to :card_flag
  has_many :financial_transactions

  # Custom validations
  before_validation :correct_format_for_values
  before_validation :disable_last_budget, on: [:create]

  # Rails validations
  # The 100 means 1,00 or 1.00 on the Operator, it means 1 currency unity (it is mult 100 because the 100 are the cents, so 10*100 is just 10 R$/US$...)
  validates :value, presence: true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, numericality: {greater_than: 50*100, less_than: 100000*100}, on: [:create, :update]

  # Validates Associations
  validates :currency_id, presence: true, on: [:create, :update]
  validates :campaign_id, presence: true, on: [:create, :update]
  validates :card_flag_id, presence: true, on: [:create, :update]
  validates :recurrence_period_id, presence: true, on: [:create, :update]

  # Callbacks after persistence events
  after_save :setup_first_transaction

  # Return the "active" transaction
  def current_transaction
    transaction = self.financial_transactions.last
    if transaction.nil? then FinancialTransaction.new else transaction end
  end

  # Method to print the value on the masked form
  def operator_value_str
    return self.value if Rents::Currency.have_cents? self.value if self.value
    self.value*10 if self.value  # it is to convert the int float, like 1.0 to 1.00
  end

  # ActiveRecord Get Method overwrite to print the real value, not the operator value
  def value
    # it is the real value, like 100, means R$1,00
    read_attribute(:value).to_f/100 if read_attribute(:value)
  end

  # Validate the payment of the Budget, based on it RID.
  # RID is the PaymentID on the RentS
  def validate_payment_of
    rid = self.id_on_operator
    transaction = Rents::Transaction.new(rid:rid)
    transaction.verify
  end

  # Return it last transaction with a purchase url
  def operator_url
    self.financial_transactions.where.not(operator_url:nil).last.operator_url
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
    def setup_first_transaction
      # Prevent it method in loop
      return unless self.financial_transactions.empty?

      # Setup vars
      amount = self.value
      card_flag_name = self.card_flag.acronym
      redirect_validate_url = Rails.application.routes.url_helpers.campaign_budget_payment_validation_path(1, 1)

      # Operator params
      operator_params = {
          # Card obj
          card:{
              flag:card_flag_name
          },

          # Transaction attrs
          amount:amount,
          redirect_link:redirect_validate_url
      }

      # Charge the transaction
      transaction = Rents::Transaction.new(operator_params)
      transaction.charge_page
      resp = transaction.resp
      status_name = resp[:status][:name]
      status_code = transaction.resp[:status][:code]

      # Params to create it financial
      financial_params = {
        value: amount,
        payment_method: 'credit_card',
        remote_id: transaction.rid,
        status_name: status_name,
        status_code: status_code,
        operator_url: transaction.purchase_url,
        currency_id: self.currency_id
      }

      # Save those information retrieved
      self.financial_transactions << FinancialTransaction.new(financial_params)

      # persist it
      saved = self.save

      unless saved
        self.errors.add('Operator attrs', 'impossible to be saved')
        raise ActiveRecord::Rollback
      end
    end

  # TODO active significa que é o orçamento corrente este que o usuário está usando
  # TODO lembrar que os orçamentos nunca são editados, sempre são criados novos
end
