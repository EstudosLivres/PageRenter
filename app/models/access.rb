class Access < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :profile

  # Custom validations/setup
  before_validation :setup

  # Rails validations
  validates_inclusion_of :converted, in: [true, false], on: [:create, :update]
  validates_inclusion_of :recurrent, in: [true, false], on: [:create, :update]

  # Validates Associations
  validates :ad_id, presence: true, on: [:create, :update]
  validates :profile_id, presence: true, on: [:create, :update]

  # Callbacks
  private
    # Base setup it attrs
    def setup
      self.converted = false if self.converted.nil?
      self.recurrent = false if self.recurrent.nil?
    end
end
