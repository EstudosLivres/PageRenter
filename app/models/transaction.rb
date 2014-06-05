class Transaction < ActiveRecord::Base
  has_one :receipt
  belongs_to :payment_method
  belongs_to :payer, :class_name => 'Campaigns'
  belongs_to :receiver, :class_name => 'User'
end
