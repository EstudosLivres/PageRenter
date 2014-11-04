class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_or_token, except: [:home]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_nested # All controller must have the set_nested, if do not depend it is an empty method
  before_action :validate_permission # All controller must have validate_permission, if is a global object it is an empty method

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:locale, :name, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    I18n.locale = @current_user.locale || I18n.default_locale unless @current_user.nil?
  end

  # Validate user session if is not API call
  def authenticate_or_token
    authenticate_user! if params[:controller].index('api').nil?
  end
end
