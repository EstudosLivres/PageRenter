class Access < ActiveRecord::Base
  # Relations
  belongs_to :profile
  belongs_to :ad

  # Custom validations/setup
  before_validation :setup

  # Rails validations
  validates :converted, presence: true, on: [:create, :update]
  validates :recurrent, presence: true, on: [:create, :update]

  # Validates Associations
  validates :profile_id, presence: true, on: [:create, :update]
  validates :ad_id, presence: true, on: [:create, :update]

  private
    def setup
      self.converted = false if self.converted.nil?
      self.recurrent = false if self.recurrent.nil?
    end
end
