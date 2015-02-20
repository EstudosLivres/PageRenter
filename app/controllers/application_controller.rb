class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  @@host # Static var to be able to access what is it host from models
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_or_token # SetUp user devise if
  before_action :set_nested # All controller must have the set_nested, if do not depend it is an empty method
  before_action :validate_permission # All controller must have validate_permission, if is a global object it is an empty method
  before_filter :setup_default_role # SetUp the user default role
  protect_from_forgery with: :exception

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:locale, :name, :username, :email, :password, :password_confirmation, :role, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :role) }
      I18n.locale = @current_user.locale || I18n.default_locale unless @current_user.nil?
    end

    # Validate user session if is not API call
    def authenticate_or_token
      @@host = request.host_with_port
      return if params[:action].index('login') || params[:controller] == 'accesses'
      authenticate_user! if params[:controller].index('api').nil? && request.fullpath != root_path
      @current_user = current_user if @current_user.nil?
    end

    # SetUp it user default role
    def setup_default_role
      # Prevent to continuous if the is no user, like on the Login or for API
      @current_user.nil? ? return : @current_user = current_user

      # Check/setup default role only for index calls
      if params[:action] == 'index'
        begin
          it_user_profile = @current_user.send(params[:controller].singularize)
          it_user_profile.set_it_as_default unless it_user_profile.nil?
        rescue
          return
        end
      end
    end

    # return it static host (it is to have the host on the model)
    def self.host
      @@host
    end

    # TODO those methods must be on the controllers which it is need
    def set_nested
    end

    def validate_permission
    end
end
