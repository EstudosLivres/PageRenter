class CampaignHistoryState < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :campaign_state
end
