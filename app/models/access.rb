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
  validates_inclusion_of :profile_id, in: [true, false], on: [:create, :update]
  validates_inclusion_of :ad_id, in: [true, false], on: [:create, :update]

  # Callbacks
  private
    # Base setup it attrs
    def setup
      self.converted = false if self.converted.nil?
      self.recurrent = false if self.recurrent.nil?
    end
end
