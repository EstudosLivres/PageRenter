class Segment < ActiveRecord::Base
  # Relations
  has_and_belongs_to_many :ads
  has_many :social_sessions, through: :social_session_segments

  # Rails validations

end
