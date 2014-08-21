class ApplicationController < ActionController::Base
  include ApplicationHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  # Validate the session
  before_action :validate_session, :except => :redirect_index

  # SetUp user
  before_action :setup_user, :except => :redirect_index

  def set_locale
    user_params = params['user']
    if user_params.is_a?(String) && user_params.length >= 2
      user_params = JSON.parse(user_params)

      if user_params.is_a?Hash
        if (user_params.has_key?('locale') && (user_params['locale'].length >= 2))
          session[:user_idiom] = user_params['locale']
        end
      end
    end

    # Idiom setted by the session just if necessary to find the user on BD, if the locale cames with the browser, it is scaped
    unless session[:user_id].nil?
      @current_user = User.where(id:session[:user_id]).take
      if @current_user.nil?
        session.delete('user_id')
        return redirect_to ApplicationController.land_url
      else
        @current_user.locale[0..1] unless session[:user_id].nil?
        I18n.locale = @current_user.locale[0..1] || I18n.default_locale
      end
    end
  end

  def validate_session
    action = params['action']
    return if is_api_call?
    if session[:user_id].nil? && action != 'system_signup_signin' && action != 'login' && action != 'mob_login' && action !='auth'
      redirect_to ApplicationController.land_url
    end
  end

  def setup_user
    # TODO if Publisher agree to use auto pub register the user using Cookies, not Sessions

    return if is_api_call?
    # SetUp the user to prevent finds on BD
    if session['user_id'].nil? || params['action'] == 'sign_out' then return end
    if @current_user.nil?
      begin
        @current_user = User.find(session['user_id'])
      rescue
        session[:user_id] = nil
        return
      end
    end

    # SetUp the current/default user profile
    single_role_name = role_name
    @current_user.set_default_profile(single_role_name)
  end

  # Prevent validate Login if it is an API call
  def is_api_call?
    return "#{/^.*?(?=\/)/.match(params[:controller])}" == 'api'
  end

  def self.land_url
    # 'http://pagerenter.com.br'
    'http://localhost/LandPageRenter/LandPageRenter/'
  end
end
