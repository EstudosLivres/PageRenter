class CampaignHistoryState < ActiveRecord::Base
  # Relations
  belongs_to :campaign
  belongs_to :campaign_state

  # Validates Associations
  validates :campaign_id, presence: true, on: [:create, :update]
  validates :campaign_state_id, presence: true, on: [:create, :update]
end
