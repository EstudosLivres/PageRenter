class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  before_action :setup_aux_objs, only: [:new, :edit]

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
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
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
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
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
      @campaign = Campaign.find(params[:campaign_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:name, :redirect_link, :title, :description, :social_phrase, :avatar)
    end
end
