class Users::PasswordsController < Devise::PasswordsController
  # Custom layout
  layout 'sign'

  private
  def set_nested
  end

  def validate_permission
  end
end
