class User < ActiveRecord::Base
  # Relations
  has_many :profiles
  has_many :social_sessions
  has_many :ads, class_name: 'Ad', foreign_key: :advertiser_id

  # Custom validations
  validate :solve_locale
  validate :encrypt_password

  # Rails validations
  validates :name, presence: true, length: { in: 3..55 }, on: [:create, :update]
  validates :username, presence: true, length: { in: 2..30 }, uniqueness: true, on: [:create, :update]
  validates :email, presence: true, length: { in: 5..55 }, uniqueness: true, on: [:create, :update]
  validates :locale, presence: true, length: { is: 5 }, on: [:create, :update]

  # Validates Associations

  # Encrypt the pasword using BCrypt
  def encrypt_password
    if password.present? && !pass_salt.present?
      self.pass_salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, pass_salt)
    end
  end

  # Solve the idiom issues
  def solve_locale
    # Refect locale for optimized Locale (pt_PT != pt_BR)
    if self.locale == 'pt' then self.locale = 'pt'+'_BR'
    elsif self.locale == 'en' then self.locale = 'en'+'_US'
    elsif self.locale.length != 5 then self.locale = 'en'+'_US' end
  end

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

  def get_profile(profile_name)
    self.profiles.each do |profile|
      return profile if profile.role.name == profile_name
    end

    return nil
  end

  # Set the current actived (rendered) profile as default
  def set_default_profile(role_name)
    profiles.each do |profile|
      if profile.role.name != role_name then default = false else default = true end
      profile.update(default_role: default)
    end
  end

  # Return the User default Account
  def get_default_profile
    self.profiles.each do |profile|
      return profile if profile.default_role
    end

    # If passed here is because there is no default role, so setup based on user app usage
    amount_campaigns = self.campaigns.length
    self.profiles.each do |profile|
      return profile if profile.role.name == 'advertiser' && amount_campaigns >= 1
      return profile if profile.role.name == 'publisher' && amount_campaigns == 0
    end
  end

  # ----- STATICs AUX METHODs TO CREATE USERs -----

  # Auth user
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.pass_salt) then user else nil end
  end

  # Method that encapsulate the User creation rule
  def self.new_user_with_it_role(user_hash)
    user_hash = SocialSession.to_user(user_hash) if user_hash.has_key?('social_session')
    user_hash_full = user_hash
    if user_hash_full.has_key?('social_session') then user_hash = SocialSession.to_user(user_hash_full) end

    # Prevent to instantiate a new user without valid attrs
    begin
      # Create a specific user_hash for social entries
      if user_hash_full.has_key?('social_session')
        user_hash = {name:user_hash[:name], username:user_hash[:username], email:user_hash[:email], locale:user_hash[:locale], role:user_hash[:role]}
      end

      return_user = User.new(user_hash.except('role', :role, 'gender'))
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
    user_hash = JSON.parse(user_hash) if user_hash.is_a?(String)
    social_hash = User.new_social_user(user_hash)

    # Validate the authentication based if the user is social session
    if social_hash.nil?
      # Prevent the process if the user is already registered (just return it to the controller log him)
      user = User.authenticate(user_hash['email'], user_hash['password'])
      return user unless user.nil?
    else
      # Prevent the process if social session registered
      user = SocialSession.authenticate(user_hash)
      return user unless user.nil?
    end

    # Prepare the user with it default role for registration
    user = User.new_user_with_it_role(user_hash) unless user_hash.has_key?('social_session')
    user = User.new_user_with_it_role(SocialSession.to_user(user_hash)) if user_hash.has_key?('social_session')
    return User.throw_user_with_error unless user.is_a?(User)

    # Add the SocialSession to the user, if it is needed
    begin
      social_hash = RailsFixes::Util.action_controller_to_hash(social_hash)
      social_session = SocialSession.setup(social_hash) unless social_hash.nil?
    rescue Exception => e
      if e.to_s == 'ActiveModel::ForbiddenAttributesError'
        social_session = SocialSession.setup(social_hash)
        return User.throw_user_with_error if social_session.nil?
      else
        return User.throw_user_with_error
      end
    end

    # User save
    if user.save
      social_session.add_it_to(user) unless social_session.nil?
      return user
    else
      return user
    end
  end

  # Throws an user with errors
  def self.throw_user_with_error
    simple_user = User.new
    simple_user.errors.messages[:invalid_user_attrs] = 'Invalid attrs to instantiate an User'
    return simple_user
  end
end
