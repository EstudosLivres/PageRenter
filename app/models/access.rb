class Access < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :profile

  # Custom validations/setup
  before_validation :setup
  validate :valid_token, on: [:create]

  # Rails validations
  validates_inclusion_of :converted, in: [true, false], on: [:create, :update]
  validates_inclusion_of :recurrent, in: [true, false], on: [:create, :update]
  validates :token, presence: true, length: { in: 10..255 }, on: [:create, :update]

  # Validates Associations
  validates :ad_id, presence: true, on: [:create, :update]
  validates :profile_id, presence: true, on: [:create, :update]

  def publisher
    self.profile
  end

  def publisher_id
    self.profile_id
  end

  # Callbacks
  private
    # Base setup it attrs
    def setup
      self.converted = false if self.converted.nil?
      self.recurrent = false if self.recurrent.nil?
    end

    # Check if the token already exist, if yes it receive an append & the check is retried...
    def valid_token
      # generate the token
      self.token=Digest::MD5.hexdigest("#{Time.now}-#{self.ad_id}-#{self.publisher_id}")

      # Aux var to the ValidatorLoop
      counter = 0

      # Loop which validate the token on the DB
      while true do
        another_access = Access.where(token: self.token).take
        break if another_access.nil?
        self.token="#{self.token}#{counter}"
        counter=counter+1
      end
    end
end
