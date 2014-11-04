class FinancialTransaction < ActiveRecord::Base
  # Associations
  has_one :receipt
  belongs_to :payment_method
  belongs_to :currency
  belongs_to :payer, :class_name => 'Campaign', foreign_key: :payer_id
  belongs_to :receiver, :class_name => 'User', foreign_key: :receiver_id

  # Custom validations
  before_validation :set_nil_to_default_value

  # Validates Attrs
  validates :value, length: { in: 2..10 }, presence: true, on: [:create, :update] # 2 chars means it cents
  validates :withdraw, presence: true, on: [:create, :update] # means if it is Page earn or User earn
  validates :payment_method, length: { in: 5..50 }, presence: true, on: [:create, :update]
  validates :remote_id, presence: true, on: [:update]

  # Validates Associations
  validates :user_id, presence: true, on: [:create, :update]
  validates :currency_id, presence: true, on: [:create, :update]

  # TODO enum banking_or_online (TRUE is banking & FALSE if online/system)

  private
    # Default values, preventing bugs/inconsistency
    def set_nil_to_default_value
      self.withdraw = false if self.withdraw.nil?
      self.currency_id = Currency.first.id if self.currency_id.nil?
    end
end
