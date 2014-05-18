class User < ActiveRecord::Base
  # Relations
  has_many :user_profile_per_roles

  # Custom validations
  validate :solve_locale
  validate :encrypt_password

  # Rails validations
  validates :name, presence: true, length: { in: 3..55 }, on: :create
  validates :nick, presence: true, length: { in: 2..30 }, uniqueness: true, on: :create
  validates :email, presence: true, length: { in: 5..55 }, uniqueness: true, on: :create
  validates :locale, presence: true, length: { is: 5 }, on: :create
  validates :pass_salt, presence: true, length: { is: 29 }, on: :create
  validates :password, presence: true, length: { is: 60 }, on: :create

  # Encrypt the pasword using BCrypt
  def encrypt_password
    if password.present? && !pass_salt.present?
      self.pass_salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, pass_salt)
    end
  end

  # Auth user
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.pass_salt) then user else nil end
  end

  # Solve the idiom issues
  def solve_locale
    # Refect locale for optimized Locale (pt_PT != pt_BR)
    if self.locale == 'pt' then self.locale = 'pt'+'_BR'
    elsif self.locale == 'en' then self.locale = 'en'+'_US'
    elsif self.locale.length != 5 then self.locale = 'en'+'_US' end
  end

  # Method that encapsulate the User creation rule
  def self.create_one_user user_hash
    user_hash_full = user_hash
    return_user = User.new(user_hash_full.except('role'))
    return_user.user_profile_per_roles = [].append UserProfilePerRole.new({ name: '', default_role: true, role_id: Role.find_by_name(user_hash['role']).id })

    return_user
  end

  # Return the User default Account
  def get_default_profile
    self.user_profile_per_roles.each do |profile|
      return profile if profile.default_role == true
    end
  end

  # Return the name per role (Adv/Pub) or User name if the current is not named
  def get_current_name
    # TODO
  end
end
