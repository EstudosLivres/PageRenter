class SocialSessionSegment < ActiveRecord::Base
  belongs_to :segment
  belongs_to :social_session
end
