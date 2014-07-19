class FinancialTransaction < ActiveRecord::Base
  has_one :receipt
  belongs_to :payment_method
  belongs_to :payer, :class_name => 'Campaign', foreign_key: :payer_id
  belongs_to :receiver, :class_name => 'User', foreign_key: :receiver_id

  # Validates Attrs
  validates :value, presence: true, on: [:create, :update]
  validates :currency, presence: true, length: { in: 3..45 }, on: [:create, :update]
  validates :banking, presence: true, on: [:create, :update]
  validates :payment_method_id, presence: true, on: [:create, :update]

  # Validates Associations
  validates :payer_id , presence: true, on: [:create, :update]
  validates :receiver_id, presence: true, on: [:create, :update]
  validates :payment_method_id, presence: true, on: [:create, :update]

  # TODO enum banking_or_online (TRUE is banking & FALSE if online/system)
end
