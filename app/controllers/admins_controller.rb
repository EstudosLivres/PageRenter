class AdminsController < ApplicationController
  # GET /admins
  def index
  end

  # GET /admins/login
  def login
    redirect_to admin_root_url unless @current_user.nil?
  end
end
