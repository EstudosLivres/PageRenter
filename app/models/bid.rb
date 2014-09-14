class Bid < ActiveRecord::Base
  belongs_to :ad
  belongs_to :currency
end
