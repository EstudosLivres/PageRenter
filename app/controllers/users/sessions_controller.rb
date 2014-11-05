class Users::SessionsController < Devise::SessionsController
  layout 'sign'

  private
    def set_nested
    end

    def validate_permission
    end
end
