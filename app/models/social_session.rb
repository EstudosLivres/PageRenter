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
  validates :friend_count, presence: true, on: [:create, :update]
  validates :local_interactions, presence: true, on: [:create, :update]
  validates :local_interaction_id, presence: true, on: [:create, :update]
  validates :foreign_interactions, presence: true, on: [:create, :update]
  validates :foreign_interaction_id, presence: true, on: [:create, :update]

  # Validates Associations
  validates :user_id, presence: true, on: [:create, :update]
  validates :social_network_id, presence: true, on: [:create, :update]

  # Add the current SocialSession to the passed user
  def add_it_to(user)
    user.social_sessions << self
  end

  # ----- STATICs AUX METHODs -----

  def self.has_it?(user, social_network)
    # How to do an association assertive
    !user.social_sessions.where(social_network_id: social_network.id).take.nil?
  end

  # Convert social_hash into socials session instance
  def self.setup(social_hash)
    social_for_instantiation = social_hash[:social_session]
    social_for_instantiation = RailsFixes::Util.action_controller_to_hash(social_for_instantiation)

    # Prevent bug by passing wrong social_hash structure
    return nil if !social_for_instantiation.is_a?(Hash)
    return nil if !social_for_instantiation.has_key?(:login) && !social_for_instantiation.has_key?(:pages)

    # Aux hashes
    login = RailsFixes::Util.action_controller_to_hash(social_for_instantiation[:login])
    pages = RailsFixes::Util.action_controller_to_hash(social_for_instantiation[:pages])[:data]

    # Prepare socials session hash
    login[:id_on_social] = login[:id]
    login[:social_network_id] = login[:network_id]
    login.delete(:network_id)
    login.delete(:id)
    social_session = SocialSession.new(RailsFixes::Util.action_controller_to_hash(login).except(:role))

    # Prepare page account hash
    if pages.is_a?(Array)
      pages.each do |page|
        # Change page attrs socials to our DB
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

  # Authenticate the socials session based on it specific rules
  def self.authenticate(social_hash)
    # Prevent the case the network passed doesn't exist
    begin
      social_network = SocialNetwork.where(username: social_hash[:social_network]).take
    rescue
      return {error:'Invalid socials networking'}
    end

    # Call the authentication dynamic
    authenticated = SocialSession.send("authenticate_#{social_network.name.downcase}", social_hash)
    if authenticated
      return authenticated
    else
      return false
    end
  end

  # Auth the user by FQL
  def self.authenticate_facebook(social)
    user = User.where(email:social[:email]).take
    return false if user.nil?
    social_user=user.social_sessions.where(email:social[:email],id_on_social:social[:id],username:social[:username],user_id:user.id).take
    social_user.nil? ? false : user
  end

  # Auth the user by OAuth
  def self.authenticate_twitter(social)
  end
end
