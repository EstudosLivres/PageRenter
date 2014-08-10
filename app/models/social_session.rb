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

  def self.has_it?(user, social_network)
    # How to do an association assertive
    !user.social_sessions.where(social_network_id: social_network.id).take.nil?
  end

  # Convert social_hash into social session instance
  def self.setup(social_hash)
    social_for_instantiation = social_hash[:social_session]
    social_for_instantiation = RailsFixes::Util.action_controller_to_hash(social_for_instantiation)

    # Prevent bug by passing wrong social_hash structure
    return nil if !social_for_instantiation.is_a?(Hash)
    return nil if !social_for_instantiation.has_key?(:login) && !social_for_instantiation.has_key?(:pages)

    # Aux hashes
    login = RailsFixes::Util.action_controller_to_hash(social_for_instantiation[:login])
    pages = RailsFixes::Util.action_controller_to_hash(social_for_instantiation[:pages])[:data]

    # Prepare social session hash
    login[:id_on_social] = login[:id]
    login[:social_network_id] = login[:network_id]
    login.delete(:network_id)
    login.delete(:id)
    social_session = SocialSession.new(RailsFixes::Util.action_controller_to_hash(login).except(:role))

    # Prepare page account hash
    if pages.is_a?(Array)
      pages.each do |page|
        # Change page attrs social to our DB
        page = RailsFixes::Util.action_controller_to_hash(page)
        page[:id_on_social] = page[:id]
        page.delete(:id)

        page_persisted = PageAccount.new(page.except(:perms))
        page_persisted.save
        social_session.page_accounts << page_persisted
      end
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
    # Prevent the case the network passed doesn't exist
    begin
      user_social_network = social_hash['social_session']['login']['network']
      social_network = SocialNetwork.find(user_social_network.to_i)
    rescue
      return {error:'Invalid social networking'}
    end

    # Call the authentication dynamic
    authenticated = SocialSession.send("authenticate_#{social_network.name.downcase}", social_hash['social_session']['login'])
    if authenticated
      user_hash = SocialSession.to_user(social_hash)
      return User.where(email: user_hash['email']).take
    else
      return {error:'Invalid social attrs'}
    end
  end

  # Auth the user by FQL
  def self.authenticate_facebook(social)
    options = { access_token: Rails.application.secrets.facebook_key }
    query = "SELECT uid FROM user WHERE email='#{social['email']}' AND uid=#{social['id']} AND username='#{social['username']}' AND locale='#{social['locale']}'"
    fb_resp = Fql.execute(query, options)
    fb_resp.empty? ? false : true
  end

  # Auth the user by OAuth
  def self.authenticate_twitter(social)
  end
end
