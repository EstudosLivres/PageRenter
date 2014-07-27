class Campaign < ActiveRecord::Base
  # Relations
  has_many :ads
  has_many :budgets
  belongs_to :user
  belongs_to :advertiser, class_name: 'Profile', foreign_key: :advertiser_id

  # Rails validations
  validate :validate_end_date_before_launch_date, on: [:create, :update]
  validates :name, presence: true, length: { in: 5..75 }, on: [:create, :update]
  validates :launch_date, presence: true, on: [:create, :update]
  validates :end_date, presence: true, on: [:create, :update]

  # Validate the End be greater than Launch
  def validate_end_date_before_launch_date
    if launch_date && end_date
      if launch_date >= end_date && launch_date >= Date.today
        self.errors.add(:end_date, 'End date should be greater than launch date')
        raise ActiveRecord::Rollback
      end
    end
  end
end
