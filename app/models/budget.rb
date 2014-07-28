class Budget < ActiveRecord::Base
  belongs_to :currency
  belongs_to :campaign
  belongs_to :recurrence_period
end
