class SocialSession < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :social_network
  has_and_belongs_to_many :page_accounts
end
