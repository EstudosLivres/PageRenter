class AdHistoryStatesController < ApplicationController
  before_action :setup_aux_objs

  # GET /campaigns
  # GET /campaigns.json
  def index
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def setup_aux_objs
      @campaign = Campaign.find(params[:campaign_id])
      @ads = @campaign.ads
    end
end
