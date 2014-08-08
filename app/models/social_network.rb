class SocialNetwork < ActiveRecord::Base
  # Relations
  has_many :social_sessions

  # Attrs validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :acronym, length: { in: 2..10 }, on: [:create, :update]
  validates :username, length: { in: 2..25 }, on: [:create, :update]

  # Validates Associations
end
