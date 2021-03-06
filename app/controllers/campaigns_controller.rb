class CampaignsController < ApplicationController
  before_action :setup_aux_objs
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = @current_user.advertiser.campaigns
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    redirect_to root_url if(@campaign.advertiser.id != @current_user.advertiser.id)
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.advertiser_id = @current_user.advertiser.id

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: {type: :success, strong: 'Congratulations!', msg: 'Your campaign was successfully created.'} }
        format.json { render action: 'show', status: :created, location: @campaign }
      else
        format.html { render action: 'new' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: {type: :success, strong: 'Congratulations!', msg: 'Campaign was successfully updated.'} }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
      forbidden = {notice: {type: 'danger', strong: 'acesso negado', msg: 'Você não tem acesso à essa opção'}}
      redirect_to '/advertisers', :flash => forbidden if @campaign.advertiser.id != @current_user.advertiser.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:name, :campaign_type_id, :launch_date, :end_date)
    end

    # Create objs to auxiliary on create forms
    def setup_aux_objs
      @campaign_types = CampaignType.all
    end
end
