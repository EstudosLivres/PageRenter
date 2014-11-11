class Users::RegistrationsController < Devise::RegistrationsController
  # Custom layout
  layout 'sign'

  def create
    build_resource(sign_up_params.except(:role))
    u = User.persist_it(user_params)
    if u.errors.empty?
      if u.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        resource = u
        sign_in(resource_name, resource)
        return respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        return respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      return respond_with resource
    end
  end

  private
    def set_nested
    end

    def validate_permission
    end

    def user_params
      params.require(:user).permit(:role, :locale, :name, :username, :email, :password)
    end
end