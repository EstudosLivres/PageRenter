class Users::RegistrationsController < Devise::RegistrationsController
  layout 'sign'
  private
    def set_nested
    end

    def validate_permission
    end
end