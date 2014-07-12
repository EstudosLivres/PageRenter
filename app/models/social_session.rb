class SocialSession < ActiveRecord::Base
  # Relations
  belongs_to :user
  belongs_to :social_network
  has_and_belongs_to_many :page_accounts

  # Rails validations
  validates :id_on_social, presence: true, length: { maximum: 45 }, on: [:create, :update]
  validates :name, presence: true, length: { maximum: 65 }, on: [:create, :update]
  validates :username, presence: true, length: { maximum: 45 }, on: [:create, :update]
  validates :email, presence: true, length: { maximum: 55 }, on: [:create, :update]
  validates :gender, presence: false, length: { maximum: 10 }, on: [:create, :update]
  validates :locale, presence: true, length: { maximum: 5 }, on: [:create, :update]
  validates :count_friends, presence: true, on: [:create, :update]

  # Validates Associations
  validates :user_id, presence: true, on: [:create, :update]
  validates :social_network_id, presence: true, on: [:create, :update]

  # Add the current SocialSession to the passed user
  def add_it_to(user)
    user.social_sessions << self
  end

  # Convert social_hash into social session instance
  def self.setup(social_hash)
    social_for_instantiation = social_hash['social_session']
    login = social_for_instantiation['login']
    pages = social_for_instantiation['pages']['data']

    # Prepare social session hash
    login['id_on_social'] = login['id']
    login['social_network_id'] = login['network_id']
    login.delete('network_id')
    login.delete('id')
    social_session = SocialSession.new(login.except('role'))

    # Prepare page account hash
    pages.each do |page|
      # Change page attrs social to our DB
      page['id_on_social'] = page['id']
      page.delete('id')

      social_session.page_accounts << PageAccount.new(page.except('perms'))
    end

    social_session
  end

  # Convert social_hash into user_hash
  def self.to_user(social_hash)
    user_hash = social_hash['social_session']['login']
    user_hash['role'] = 'publisher'
    user_hash.except('count_friends', 'id', 'network_id')
  end

  # Authenticate the social session based on it specific rules
  def self.authenticate(social_hash)
    user_hash = SocialSession.to_user(social_hash)
    return User.where(email: user_hash['email']).take
  end
end
