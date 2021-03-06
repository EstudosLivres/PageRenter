class Profile < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :role
  has_many :campaigns, class_name: 'Campaign', foreign_key: :advertiser_id
  has_attached_file :avatar,
                    storage: :s3,
                    s3_credentials: "#{Rails.root}/config/aws.yml",
                    path: ":class/:attachment/:id/:style/:filename",
                    url: ':s3_domain_url',
                    styles: { thumb:'100x15' },
                    default_url: 'missing_logo.png'

  # Validates Associations
  before_validation :prevent_duplicated_username, on: :update
  validates :user_id, presence: true, on: :update
  validates :role_id, presence: true, on: :update
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 45.kilobyte

  # Constants
  enum role_name: { admin: 1, publisher: 2, advertiser: 3 }

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

  # Turn it as the default to the user
  def set_it_as_default
    self.user.set_default_profile self.role.name
  end

  def self.get_default_role profiles
    profiles.each do |profile|
      if profile.default_role then return profile.role.name end
    end
  end

  private
    # It prevent the Profile use an username already taken by an User
    def prevent_duplicated_username
      user_with_it_username = User.where(username: self.username).take

      unless user_with_it_username.nil?
        self.errors.add('username', 'already taken')
        raise ActiveRecord::Rollback
      end
    end
end
