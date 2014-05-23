class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    session['user_idiom'] = JSON.parse(params['user'])['locale']
    if session['user_idiom'].nil? then session['user_idiom'] = User.find(session['user_id']).locale[0..1] end
    I18n.locale = session['user_idiom'] || I18n.default_locale
  end

  def self.land_url
    # 'http://pagerenter.com.br'
    'http://localhost/LandPageRenter/LandPageRenter/'
  end
end
