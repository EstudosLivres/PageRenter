class HomeController < ApplicationController
  def index
    if @current_user.nil? then redirect_to new_session_path(User.new) else redirect_to "/#{@current_user.get_default_profile.role.name.pluralize}" end
  end
end
