class PaymentMethods < ActiveRecord::Base
  has_many :transactions
end
