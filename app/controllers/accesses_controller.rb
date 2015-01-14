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

      # Check if it is necessary to clear the cookies based on: there is any access for any day before today?
      get_accesses_cookie.values.each {|access|  Date.strptime(access[0, access.index('-')], '%d/%m') < Date.today ? clear_cookie : next }

      # Base Access instantiated & after setup it attrs
      @access = Access.new(ad_id:@ad.id, profile_id:@publisher.id)
      recurrent? ? @access.recurrent = true : @access.recurrent = false

      # Finish it access registration
      access_saved = @access.save

      # Register on the user Cookie
      register_cookie_access if access_saved
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
      @ad = Ad.where(username: params[:ad_username], campaign_id: params[:campaign_id]).take
      @user = User.where(username: params[:publisher_username]).take
      @publisher = @user.publisher unless @user.nil?
    end

    # It return true if the user already access it
    def recurrent?
      # if there is no cookies access it is the user first time here
      return false if get_accesses_cookie.empty?

      # The user accessed some URL, but not this one
      return false if @access_data.nil?

      # If there is no access expression on the cookie
      get_accesses_cookie[access_expression].nil? ? false : true
    end

    # SetUp all the validations to guarantee it uniqueness
    def register_cookie_access
      # setup accesses attr on the cookie if it is not created, else check if is it to clear the cookie
      if cookies[:accesses].nil? || !get_accesses_cookie.is_a?(Hash)
        create_accesses_cookie
      else
        # Retrieve the access, based on it expression
        @access_data = get_accesses_cookie[access_expression]

        # Check if the date is today, if not, clear his cookie
        unless @access_data.nil?
          access_date = Date.parse(@access_data+"/#{Time.now.year}")
          clear_cookie if access_date < Date.today
        end
      end

      # The cookie[:accesses] is a Hash, retriUsing unshift (push in the begging of the array because if the user is recurrent it is more probably to be the last access)
      add_to_cookie(access_expression, "#{Time.now.strftime('%d/%m')}-#{Time.now.strftime('%H:%M:%S')}")
    end

    # Recreate the empty hash accesses
    def clear_cookie
      create_accesses_cookie
    end

    # The cookie doesn't support Hash, so use JSON String
    def create_accesses_cookie
      cookies[:accesses] = {}.to_json
    end

    # The cookie doesn't support Hash, so use JSON String
    def get_accesses_cookie
      create_accesses_cookie if cookies[:accesses].nil
      JSON.parse(cookies[:accesses])
    end

    # The cookie doesn't support Hash, so use JSON String
    def add_to_cookie key, value
      cookie_hash = get_accesses_cookie
      cookie_hash[key] = value
      cookies[:accesses] = cookie_hash.to_json
    end

    # Method to reuse it expressions
    def access_expression
      setup_register_objs if @user.nil? || @publisher.nil? || @ad.nil?
      "#{@publisher.id}-#{@ad.id}-#{@access.token}"
    end
end
