class Ad < ActiveRecord::Base
  # Relations
  belongs_to :campaign
  has_many :bank_transactions
  has_many :ad_history_states
  has_many :ad_states, through: :ad_history_states
  has_attached_file :avatar,
                    url: "/post_images/:style/:filename",
                    :styles => { :medium => '470x300>', :thumb => '117x75>' },
                    :default_url => '/assets/:style/missing_ad_avatar.jpg'

  # Custom validations
  after_create :setup

  # Rails validations
  validates :name, presence: true, length: { in: 3..50 }, on: [:create, :update] # appears just for the Advertiser (to easy differentiate campaigns)
  validates :redirect_link, presence: true, length: { in: 15..1240 }, on: [:create, :update] # where the user gonna be appointed
  validates :title, presence: true, length: { in: 3..50 }, on: [:create, :update] # which appears to call attention from the publisher
  validates :description, presence: true, length: { in: 5..140 } # which the campaign is about
  validates :social_phrase, presence: false # Social phrase is not required
  validates :campaign_id, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Validates Associations
  validates :campaign_id, presence: true, on: [:create, :update]

  # SetUp the Ad base state (the Ad object attr when created)
  def setup
    # It starts as pending
    self.ad_states = [AdState.where(name:'pending').take!]

    # TODO self.username = regex to change special character to normal &
    self.save
  end

# TODO def budget: return the transactions without receiver which means paid to the system
=begin
  def update_it
    # current_value_on_bd =
    # current_value_on_memory =
    # if != insert new clickvalue
  end
=end
end
