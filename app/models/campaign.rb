class Campaign < ActiveRecord::Base
  # Relations
  has_many :ads
  has_many :budgets
  belongs_to :campaign_type
  belongs_to :advertiser, class_name: 'Profile', foreign_key: :advertiser_id

  # Custom validations
  validate :setup_campaign

  # Rails validations
  validate :validate_end_date_before_launch_date, on: [:create, :update]
  validates :name, presence: true, length: { in: 5..75 }, on: [:create, :update]
  validates :launch_date, presence: true, on: [:create, :update]
  validates :end_date, presence: true, on: [:create, :update]

  # Validates Associations
  validates :campaign_type_id, presence: true, on: [:create, :update]
  validates :advertiser_id, presence: true, on: [:create, :update]


  # Validate the End be greater than Launch
  def validate_end_date_before_launch_date
    if launch_date && end_date
      if launch_date >= end_date && launch_date >= Date.today
        self.errors.add(:end_date, 'End date should be greater than launch date')
        raise ActiveRecord::Rollback
      end
    end
  end

  # Return it state based on the Ads (is there is at least 1 Ad RUNNING it is RUNNING, else is all in same state (pendent, check...))
  def current_state
    return_hash = {}
    return_hash[:alert] = 'default'
    return_hash[:state] = 'PENDING'

    # Get the campaign
    campaign_ads = Ad.where(campaign_id: self.id).to_a
    return return_hash if campaign_ads.empty?

    return_hash[:alert] = 'success'
    return_hash[:state] = 'RUNNING'
    return return_hash
  end

  # Pre SteUp the campaign to it recent created rules
  def setup_campaign

  end
end
