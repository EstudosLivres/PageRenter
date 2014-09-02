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
  #validates :campaign_type_id, presence: true, on: [:create, :update]
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

  # Return it state based on the Ads (if there is at least 1 Ad RUNNING it is RUNNING, else is all in same state (pending, check...))
  def current_state
    pending_count = count_ad_state('pending')
    checked_count = count_ad_state('checked')
    suspended_count = count_ad_state('suspended')
    running_count = count_ad_state('running')
    stopped_count = count_ad_state('stopped')

    # if there is anyone running return RUNNING as it state
    return AdState.where(name:'running').take if running_count >= 1
    # suspended is the second priority
    return AdState.where(name:'suspended').take if suspended_count >= 1
    # stopped is the mid priority
    return AdState.where(name:'stopped').take if stopped_count >= 1
    # checked is the second lowest
    return AdState.where(name:'checked').take if checked_count >= 1
    # pending is the lowest priority
    return AdState.where(name:'pending').take if pending_count >= 1
  end

  # Pre SteUp the campaign to it recent created rules
  def setup_campaign

  end

  private
    def count_ad_state state_name
      AdState.joins(:ad_history_states).joins(:ads).where('ad_states.name'=>state_name, 'ads.campaign_id'=>self.id).count
    end
end
