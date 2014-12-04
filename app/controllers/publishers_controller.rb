class PublishersController < ApplicationController
  # Custom layouts for specific actions
  layout 'blank', only: [:brought_access]

  # Prevent spam USER.FIND on DB
  before_action :set_publisher, except: [:brought_access]

  # Root for Publisher user
  def index
    @activated_campaigns = Campaign.where('launch_date <= now() AND end_date >= now()')

    @ads = [] # Populate pub_piece
    @activated_campaigns.each do |campaign|
      campaign.ads.each do |ad|
        @ads.append(ad)
      end
    end

    @social_session = @current_user.get_social_network_profile('facebook')
    @pages = @social_session.page_accounts unless @social_session.nil?
  end

  # Configuration for Publisher user
  def edit
  end

  # Publisher config his social logins
  def add_social_login
    @social_networks = SocialNetwork.where(implemented: true, just_share: false)
    @user_social_sessions = @current_user.social_sessions
  end

  # PATCH/PUT /publisher/1
  # PATCH/PUT /publisher/1.json
  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to @publisher, notice: 'Publisher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET '/accesses/:publisher_username/:ad_id' -> register it access brought through it publisher
  def brought_access
    begin
      # Register it access
      Access.new(ad_id:ad,profile_id:publisher)
    rescue => e
      render file: "#{Rails.root}/public/404_accesses"
      puts "MethodError on: #{__method__}. \nError: "
      puts e
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = @current_user.publisher
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:name)
    end

    # SetUp all the validations to guarantee it uniqueness
    def register_access_to_be_unique
      # :acid = access_ids (expression to register it access)
      session[:acid] = [] if session[:acid].nil?
      # That expression is compressed because the session isn't so big to contain a lot of characters
      aid_expression = "#{params[:publisher_id]}-#{params[:ad_id]}"
      # Using unshift (push in the begging of the array because if the user is recurrent it is more probably to be the last access)
      session[:acid].unshift aid_expression
    end
end
