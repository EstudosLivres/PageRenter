class AdvertisersController < ApplicationController
  before_action :set_advertiser, only: [:show, :edit, :update, :destroy]

  before_action :set_advertiser

  # Root for Advertiser user
  def index
    @campaigns = @current_user.advertiser.campaigns
    flash[:notice] = {type: :success, strong: 'Congratulations!', msg: "Budget charged. Check if your Campaign <strong>#{params[:campaign]}</strong> was updated."} if params[:paid] == 'true'
  end

  # Configuration for Advertiser user
  def edit
  end

  # PATCH/PUT /advertiser/1
  # PATCH/PUT /advertiser/1.json
  def update
    respond_to do |format|
      if @advertiser.update(advertiser_params)
        format.html { redirect_to '/advertisers/edit', :flash => {notice: {type: 'success', strong: 'operação efetuada', msg: 'Perfil atualizado'}} }
        format.json { head :no_content }
      else
        format.html { redirect_to '/advertisers/edit', flash:{notice: {type:'danger', strong:'Erros ao atualizar seu Perfil: ', msg:@advertiser.errors.messages}} }
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
    params.require(:advertiser).permit(:name,:avatar)
  end
end
