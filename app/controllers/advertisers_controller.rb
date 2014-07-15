class AdvertisersController < ApplicationController
  # Prevent spam USER.FIND on DB
  before_action :setup_user
  before_action :set_advertiser

  # Root for Advertiser user
  def index
  end

  # Configuration for Advertiser user
  def edit
  end

  # PATCH/PUT /advertiser/1
  # PATCH/PUT /advertiser/1.json
  def update
    respond_to do |format|
      if @advertiser.update(advertiser_params)
        format.html { redirect_to @advertiser, notice: 'Advertiser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advertiser.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_advertiser
    @advertiser = @current_user.advertiser
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def advertiser_params
    params.require(:profile).permit(:name,:avatar)
  end
end
