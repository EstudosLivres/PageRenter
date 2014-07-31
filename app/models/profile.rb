class Profile < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :role
  has_many :campaigns, class_name: 'Campaign', foreign_key: :advertiser_id
  has_attached_file :avatar, :styles => { :medium => '300x75>', :thumb => '100x15>' }, :default_url => '/assets/:style/missing_logo.jpg'

  # Validates Associations
  validates :user_id, presence: true, on: [:create, :update]
  validates :role_id, presence: true, on: [:create, :update]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Constants
  enum role_name: { publisher: 1, advertiser: 2, admin: 3 }

  # Return its name if exists, else return the user owner name
  def name
    attr_name = self.attributes['name']
    if(!attr_name.nil? && attr_name.length >= 1) then return attr_name else return self.user.name end
  end

  # Return if the name is not the same as the user
  def name_if_updated
    return name if name != user.name
    return ''
  end

  def self.get_default_role profiles
    profiles.each do |profile|
      if profile.default_role then return profile.role.name end
    end
  end
end
