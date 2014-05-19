class SocialSession < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :social_network
end
