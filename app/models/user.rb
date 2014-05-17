class User < ActiveRecord::Base
  before_save :encrypt_password

  validates :name, presence: true, length: { in: 3..55 }, on: :create
  validates :nick, presence: true, length: { in: 3..30 }, uniqueness: true, on: :create, on: :update
  validates :email, presence: true, length: { in: 7..55 }, uniqueness: true, on: :create, on: :update
  validates :locale, presence: true, length: { is: 5 }, on: :create
  validates :password, length: { is: 60 }, on: :create

  # Encrypt the pasword using BCrypt
  def encrypt_password
    if password.present?
      self.password_hash = BCrypt::Engine.hash_secret(password, self.email)
    end
  end

  # Auth user
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.email) then user else nil end
  end
end
