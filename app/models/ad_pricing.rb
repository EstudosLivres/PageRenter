class AdPricing < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :currency
end
