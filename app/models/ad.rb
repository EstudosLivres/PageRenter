class Ad < ActiveRecord::Base
  # Relations
  belongs_to :campaign
  has_many :bank_transactions
  has_many :bids
  has_many :ad_history_states
  has_many :ad_states, through: :ad_history_states
  has_and_belongs_to_many :segments

  # Using pub_piece instead Ad to avoid AdBlock
  has_attached_file :avatar,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws.yml",
                    path: "pub_piece/:attachment/:id/:style/:filename",
                    url: ':s3_domain_url',
                    default_url: '/assets/missing/pub_piece/:style/missing_logo.png'

  # Custom validations
  after_create :setup

  # Rails validations
  validates :name, presence: true, length: { in: 5..50 }, on: [:create, :update] # appears just for the Advertiser (Internal control)
  validates :headline, presence: true, length: { in: 5..25 }, on: [:create, :update] # calls the publisher attention
  validates :title, presence: true, length: { in: 5..90 }, on: [:create, :update] # which appears upside the image
  validates :redirect_link, presence: true, length: { in: 12..90 }, on: [:create, :update] # which appears upside the image
  validates :username, presence: true, length: { in: 5..140 }, on: [:create, :update] # appears on the link (for Google SEO)
  validates :social_phrase, length: { in: 5..140 }, on: [:create, :update] # appears on the link (for Google SEO)
  validates :description, length: { in: 5..200 }, on: [:create, :update] # which explain what this Ad is about

  validates :campaign_id, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Validates Associations
  validates :campaign_id, presence: true, on: [:create, :update]

  # SetUp the Ad base state (the Ad object attr when created)
  def setup
    # It starts as pending
    self.ad_states = [AdState.where(name:'pending').take!]

    # TODO self.username = regex to change custom character to normal &
    self.save
  end

  # Return it advertiser based on it Campaign
  def advertiser
    self.campaign.advertiser
  end

  # Return it current activated Bid
  def bid
    return self.bids.last
  end

# TODO def budget: return the transactions without receiver which means paid to the system
end
