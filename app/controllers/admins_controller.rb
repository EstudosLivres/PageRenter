class AdminsController < ApplicationController
  # Custom layout, without navbar and anything else which need user logged
  layout 'sign', only: [:login]

  # GET /admins
  def index
  end

  # GET /admins/login
  def login
    redirect_to admin_root_url unless @current_user.nil?
  end
end
