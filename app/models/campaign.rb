class Campaign < ActiveRecord::Base
  # Relations
  belongs_to :user

  # Rails validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update]
  validates :redirect_link, presence: true, length: { in: 15..200 }, on: [:create, :update]
  validates :slogan, presence: false, length: { in: 5..65 }
  validates :description, presence: false, length: { in: 5..140 }
  validates :social_phrase, presence: false, length: { in: 5..140 }
end
