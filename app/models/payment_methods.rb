class PaymentMethods < ActiveRecord::Base
  has_many :transactions

  validates :name, presence: true, length: { in: 3..45 }, on: create
  validates :method_type, presence: true, length: { in: 3..45 }, on: create
end
