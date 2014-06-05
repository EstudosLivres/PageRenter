class Transaction < ActiveRecord::Base
  has_one :receipt
  belongs_to :payment_method
  belongs_to :payer, :class_name => 'Campaigns'
  belongs_to :receiver, :class_name => 'User'

  validates :value, presence: true, on: create
  validates :currency, presence: true, length: { in: 3..45 }, on: create
  validates :banking, presence: true, on: create
  validates :payment_method_id, presence: true, on: create

  # Validates Associations
  validates :payer_id , presence: true, on: [:create, :update]
  validates :receiver_id, presence: true, on: [:create, :update]
  validates :payment_method_id, presence: true, on: [:create, :update]
end
