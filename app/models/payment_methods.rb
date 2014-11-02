class PaymentMethods < ActiveRecord::Base
  # Associations
  has_many :bank_transactions

  # Attrs Validations
  validates :name, presence: true, length: { in: 3..45 }, on: [:create, :update]
  validates :method_type, presence: true, length: { in: 3..45 }, on: [:create, :update]

  # Validates Associations

  #
end
