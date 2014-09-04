class Bid < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :currency
end
