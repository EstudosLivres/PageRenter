class SocialSessionSegment < ActiveRecord::Base
  # Relations
  belongs_to :social_session
  has_and_belongs_to_many :segments

  # Rails validations
  validates :social_session_id, presence: false, on:[:create, :update]
  validates :id_on_social, presence: true, length: { in: 1..45 }, on:[:create, :update]
  validates_uniqueness_of :id_on_social, on: [:create, :update]
end
