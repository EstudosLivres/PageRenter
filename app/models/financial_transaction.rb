class FinancialTransaction < ActiveRecord::Base
  # Associations
  has_one :receipt
  belongs_to :budget
  belongs_to :currency
  belongs_to :payer, :class_name => 'Campaign', foreign_key: :payer_id
  belongs_to :receiver, :class_name => 'User', foreign_key: :receiver_id

  # Custom validations
  before_validation :set_nil_to_default_value

  # Validates Attrs
  validates :value, length: { in: 2..10 }, presence: true, on: [:create, :update] # 2 chars means it cents
  validates_inclusion_of :withdraw, in: [true, false], on: [:create, :update] # means if it is Page earn or User earn
  validates :payment_method, length: { in: 5..50 }, presence: true, on: [:create, :update]
  validates :remote_id, presence: true, on: [:update]

  # Validates Associations
  validates :currency_id, presence: true, on: [:create, :update]

  # TODO enum banking_or_online (TRUE is banking & FALSE if online/system)

  # Return true if it is paid & false if it is not paid yet
  def paid?
    initial_status = 0
    return false if self.status_code == initial_status
    self.status_name == 'error' ? true : false if self.status_code != initial_status
    self.status_name == 'charged' ? true : false if self.status_code != initial_status

    # Verifying transaction
    transaction = Rents::Transaction.new(rid:remote_id)
    transaction_verified = transaction.verify

    # Update it attrs
    self.status_code=transaction_verified[:status][:code]
    self.status_name=transaction_verified[:status][:name]

    # Prepare it returning
    self.status_name == 'error' ? true : false if self.status_code != initial_status
    self.status_name == 'charged' ? true : false if self.status_code != initial_status
  end

  private
    # Default values, preventing bugs/inconsistency
    def set_nil_to_default_value
      self.withdraw = false if self.withdraw.nil?
      self.currency_id = Currency.first.id if self.currency_id.nil?
    end
end
