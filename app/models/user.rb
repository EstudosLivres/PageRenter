class User < ActiveRecord::Base
  before_save :encrypt_password

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
