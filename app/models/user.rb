class User < ActiveRecord::Base
  before_save :encrypt_password

  # Encrypt the pasword using BCrypt
  def encrypt_password
    if password.present?
      password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
