class ShorterLink < ActiveRecord::Base
  # Relations
  belongs_to :ad
  belongs_to :user

  # Rails validations
  validates :link, presence: true, length: { in: 8..60 }, on: [:create, :update]
  validates_uniqueness_of :link, on: [:create, :update]

  # Associations validations
  validates_presence_of :ad
  validates_presence_of :user

  # FactoryMethod
  def self.fabricate_with url, ad_username, pub_username
    # SetUp vars
    publisher = User.where(username:pub_username).take
    ad = Ad.where(username:ad_username).take
    shorter = ShorterLink.new

    # Return an empty instance
    if ad.nil? || publisher.nil?
      shorter.save
      return shorter
    end

    # Check if it shorter already exists, prevent loop GoogleAPI calls
    brought_link = ad.brought_access_link publisher.id, get_shorter_obj=true
    return brought_link if brought_link.is_a?ShorterLink

    # Add it associations if there isn't any problem
    shorter.ad = ad
    shorter.user = publisher
    shorter.link = Google::Shorter.generate url
    shorter.save # persist it

    # return the shorter fabricated
    return shorter
  end
end
