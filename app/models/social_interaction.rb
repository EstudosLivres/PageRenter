class SocialInteraction < ActiveRecord::Base
  # Associations
  belongs_to :social_session

  # Custom validations

  # Rails validations
  validates :external_id, presence: true, length: { in: 1..45 }, on: [:create, :update]
  validates :type, presence: true, length: { in: 1..45 }, on: [:create, :update]

  # Rails association validations
  validates_presence_of :social_session
end
