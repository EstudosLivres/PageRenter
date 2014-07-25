class Currency < ActiveRecord::Base
  has_many :ad_pricings
  has_many :financial_transactions
end
