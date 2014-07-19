class CampaignState < ActiveRecord::Base
  # Relations
  has_many :campaign_history_states
  has_many :campaigns, through: :campaign_history_states

  # Rails validations
  validates :name, presence: true, length: { in: 3..40 }, on: [:create, :update]
end
