class AdHistoryState < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :ad_state

  # Validates Associations
  validates :campaign_id, presence: true, on: [:create, :update]
  validates :campaign_state_id, presence: true, on: [:create, :update]
end
