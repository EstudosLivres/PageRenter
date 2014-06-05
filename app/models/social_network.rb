class SocialNetwork < ActiveRecord::Base
  # Relations
  has_many :social_sessions

  # Validates Associations
end
