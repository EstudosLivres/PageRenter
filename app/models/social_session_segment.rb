class SocialSessionSegment < ActiveRecord::Base
  # Relations
  belongs_to :segment
  belongs_to :social_session
end
