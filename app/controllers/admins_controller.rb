class AdminsController < ApplicationController
  # GET /admins
  def index
  end

  # GET /admins/login
  def login
    # Custom layout, without navbar and anything else which need user logged
    layout 'sign'
    redirect_to admin_root_url unless @current_user.nil?
  end
end
