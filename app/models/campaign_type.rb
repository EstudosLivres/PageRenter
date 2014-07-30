class CampaignType < ActiveRecord::Base
  # Relations
  has_many :campaigns

  # Rails validations
  validates :name, presence: true, length: { in: 5..35 }, on: [:create, :update]
  validates :description, presence: true, length: { in: 5..140 }, on: [:create, :update]
end
