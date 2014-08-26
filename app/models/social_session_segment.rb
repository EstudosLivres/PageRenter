class SocialSessionSegment < ActiveRecord::Base
  # Relations
  belongs_to :social_session
  has_and_belongs_to_many :social_session_segments

  # Rails validations
  validates :social_session_id, presence: false, on:[:create, :update]
  validates :id_on_social, presence: true, length: { in: 10..45 }, on:[:create, :update]
  validates_uniqueness_of :id_on_social, on:[:create, :update]
  validates_uniqueness_of :social_session_id, on:[:create, :update]
end
