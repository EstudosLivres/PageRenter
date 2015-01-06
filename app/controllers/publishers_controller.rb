class PublishersController < ApplicationController
  # Root for Publisher user
  def index
    @ads = Campaign.all_actives_ads @current_user.advertiser.id
    @social_session = @current_user.get_social_network_profile('facebook')
    @pages = @social_session.page_accounts unless @social_session.nil?
  end

  # Configuration for Publisher user
  def edit
  end

  # Publisher config his social logins
  def add_social_auth
    @social_networks = SocialNetwork.all
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = @current_user.publisher
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:name)
    end
end
