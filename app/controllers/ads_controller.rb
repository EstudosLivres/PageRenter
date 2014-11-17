class AdsController < ApplicationController
  before_action :setup_aux_objs

  # GET /Ads
  # GET /Ads.json
  def index
    @ads = Ad.all
  end

  # GET /Ads/1
  # GET /Ads/1.json
  def show
  end

  # GET /Ads/new
  def new
    @ad = Ad.new
  end

  # GET /Ads/1/edit
  def edit
  end

  # POST /Ads
  # POST /Ads.json
  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to campaign_ad_url(params[:campaign_id], @ad.id), notice: 'Ad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ad }
      else
        format.html { render action: 'new' }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Ads/1
  # PATCH/PUT /Ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to campaign_ad_url(params[:campaign_id], @ad), notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Ads/1
  # DELETE /Ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
      forbidden = {notice: {type: 'danger', strong: 'acesso negado', msg: 'Você não tem acesso à essa opção'}}
      redirect_to '/advertisers', :flash => forbidden if @ad.advertiser.id != @current_user.id
    end

    # Create objs to auxiliary on create forms
    def setup_aux_objs
      @ad = Ad.find(params[:id]) unless params[:id].nil?
      @campaign = Campaign.find(params[:campaign_id])
      # TODO return if !valid_user_permission?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      ad_hash = params.require(:ad).permit(:name, :headline, :title, :redirect_link, :username, :social_phrase, :description, :audience, :avatar)
      ad_hash[:campaign_id] = params[:campaign_id]
      ad_hash
    end
end
