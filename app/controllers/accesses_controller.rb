class AccessesController < ApplicationController
  # Before execute any action
  before_action :set_access, only: [:index, :show]
  before_action :setup_register_objs, only: [:brought]

  # Custom layouts for specific actions
  layout 'blank', only: [:brought]

  # Show all access for a Campaign or Ad
  def index
    @accesses = Access.all
    respond_with(@accesses)
  end

  # Show a specific access
  def show
    respond_with(@access)
  end

  # Register the access from the Publisher link shared
  # GET '/accesses/:publisher_username/:ad_username' -> register it access brought through it publisher
  def brought
    begin
      # SetUp error message & send it to the root
      error_msg = ''
      redirect_to "#{root_url}?danger=#{error_msg}" if @ad.nil? || @user.nil?

      # Base Access instantiated & after setup it attrs
      access = Access.new(ad_id:@ad.id, profile_id:@publisher.id)
      recurrent? ? access.recurrent = true : access.recurrent = false

      # Finish it access registration
      access.save
    rescue => e
      render file: "#{Rails.root}/public/404_accesses"
      puts "MethodError on: #{__method__}. \nError: "
      puts e
    end
  end

  # Callback methods
  private
    # Set just the access object
    def set_access
      @access = Access.find(params[:id])
    end

    # Create on the memory all objs which it depends on
    def setup_register_objs
      @ad = Ad.where(username: params[:ad_username]).take
      @user = User.where(username: params[:publisher_username]).take
      @publisher = @user.publisher unless @user.nil?
    end

    # It return true if the user already access it
    def recurrent?
      # if there is no cookies access it is the user first time here
      return false if cookies[:accesses].nil?

      # Retrieve the access, based on it expression
      access_data = cookies[:accesses][access_expression]

      # The user accessed some URL, but not this one
      return false if access_data.nil?

      # Check if the date is today, if not, clear his cookie
      access_date = Date.parse(access_data+"#{Time.now.year}")
      clear_cookie if access_date < Date.today

      # If there is no access expression on the cookie
      cookies[:accesses][access_expression].nil? ? false : true
    end

    # SetUp all the validations to guarantee it uniqueness
  def register_access_to_be_unique
    # :accesses = {} each access gone be an attr for it hash
    cookies[:accesses] = {} if cookies[:accesses].nil?
    # Using unshift (push in the begging of the array because if the user is recurrent it is more probably to be the last access)
    cookies[:accesses][access_expression] = Time.now.strftime('%d/%m')
    end

    # Recreate the empty hash accesses
    def clear_cookie
      cookies[:accesses] = {}
    end

    # Method to reuse it expressions
    def access_expression
      :"#{@user.id}-#{@pubsliher.id}-#{@ad.id}"
    end
end
