class CampaignState < ActiveRecord::Base
  has_many :campaign_history_states
  has_many :campaigns, through: :campaign_history_states
end
