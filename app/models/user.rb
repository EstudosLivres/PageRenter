class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  # Extra attrs
  attr_accessor :login

  # Relations
  has_many :profiles
  has_many :social_sessions
  has_many :campaigns, through: :profiles
  has_many :budgets, through: :campaigns

  # Custom validations
  before_validation :solve_locale

  # Rails validations
  validates :name, presence: true, length: { in: 3..55 }, on: [:create, :update]
  validates :username, presence: true, length: { in: 2..30 }, uniqueness: {case_sensitive: false}, on: [:create, :update]
  validates :email, presence: true, length: { in: 5..55 }, uniqueness: true, on: [:create, :update]
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :locale, presence: true, length: { is: 5 }, on: [:create, :update]

  # Return it first name
  def first_name
    # Regex, return the first word (split the name based on the spaces)
    self.name.split(/ /)[0]
  end

  # Return the user advertiser profile
  def advertiser
    return get_profile('advertiser')
  end

  # Return the user publisher profile
  def publisher
    return get_profile('publisher')
  end

  # Return the user admin profile
  def admin
    return get_profile('admin')
  end

  def get_profile(profile_name)
    self.profiles.each do |profile|
      return profile if profile.role.name == profile_name
    end

    return nil
  end

  # Set the current active (rendered) profile as default
  def set_default_profile(role_name)
    # Set as not default for all roles
    profiles.where(default_role:true).update_all(default_role:false)

    # Set it profile call as default
    profiles.joins(:role).where("roles.name = '#{role_name}'").update_all(default_role:true)
  end

  # Return the User default Account
  def get_default_profile
    self.profiles.each do |profile|
      return profile if profile.default_role
    end

    # If passed here is because there is no default role, so setup based on user app usage
    if self.advertiser.nil? then amount_campaigns = 0 else amount_campaigns = self.advertiser.campaigns.length end
    self.profiles.each do |profile|
      return profile if profile.role.name == 'advertiser' && amount_campaigns >= 1
      return profile if profile.role.name == 'publisher' && amount_campaigns == 0
    end
  end

  # Return it social_network profile
  def get_social_network_profile social_network_name
    return nil if self.social_sessions.empty?

    self.social_sessions.each do |social_session|
      return social_session if social_session.social_network.username == social_network_name
    end
  end

  # =============================== STATICs AUX METHODs TO CREATE USERs ============================
  # Method that encapsulate the User creation rule
  def self.new_user_with_it_role(user_hash)
    user_hash = RailsFixes::Util.hash_keys_to_sym(user_hash)
    return User.authenticate(user_hash[:email], user_hash[:password]) if user_hash[:name].empty? || user_hash[:username].empty?

    # Prevent to instantiate a new user without valid attrs
    begin
      # Create a specific user_hash for socials entries
      return_user = User.new(user_hash.except(:role))
    rescue Exception => e
      if e.to_s == 'ActiveModel::ForbiddenAttributesError'
        new_user_hash = RailsFixes::Util.action_controller_to_hash(user_hash)
        return_user = User.new(new_user_hash.except(:gender,:role))
      else
        return User.throw_user_with_error
      end
    end

    # Prevent the user with no role to be created
    role = Role.where(name: [user_hash['role'],user_hash[:role]]).take
    if role.nil? then role_id = nil else role_id = role.id end

    return_user.profiles = [].append Profile.new({ name: '', default_role: true, role_id: role_id })

    # The second role is the disabled one (not the current)
    pub_id = Role.where(name: 'publisher').take.id
    adv_id = Role.where(name: 'advertiser').take.id

    # SetUp the second_role (!default_role)
    case role_id
      when pub_id
        second_role = adv_id
      when adv_id
        second_role = pub_id
    end

    return_user.profiles << Profile.new({ name: '', default_role: false, role_id: second_role })
    return_user
  end

  # Method that encapsulate the SocialUser creation rule by receiving the user_hash (called social_hash here)
  def self.new_social_user(social_hash)
    if social_hash.has_key?('social_session') then return social_hash else return nil end
  end

  # Persist the user by it previous hash
  def self.persist_it(user_hash)
    # TODO refactor with devise
    it = self.new_user_with_it_role(user_hash)
    it.save
    return it
  end

  # Throws an user with errors
  def self.throw_user_with_error
    simple_user = User.new
    simple_user.errors.messages[:invalid_user_attrs] = 'Invalid attrs to instantiate an User'
    return simple_user
  end

  # Override Devise Auth to use USERNAME not EMAIL
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.downcase}]).first
    else
      where(conditions).first
    end
  end

  # =============================== Private methods for callbakcs ============================
  private
    # Solve the idiom issues
    def solve_locale
      # Refect locale for optimized Locale (pt_PT != pt_BR)
      if self.locale == 'pt' then self.locale = 'pt'+'_BR'
      elsif self.locale == 'en' then self.locale = 'en'+'_US'
      elsif self.locale.nil? then self.locale = 'pt'+'_BR' end
    end
end
