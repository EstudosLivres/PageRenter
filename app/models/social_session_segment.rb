class SocialSessionSegment < ActiveRecord::Base
  # Relations
  belongs_to :social_session
  has_and_belongs_to_many :social_session_segments
end
